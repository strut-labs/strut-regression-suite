#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from typing import Sequence

ROOT = Path(__file__).resolve().parent
PROCESS_TIMEOUT = 90.0
PROCESS_EXPECTATIONS = {"exit", "stdout", "stderr", "stdout_contains", "stderr_contains"}

def run_process(*args, **kwargs):
    kwargs.setdefault("timeout", PROCESS_TIMEOUT)
    return subprocess.run(*args, **kwargs)



def load_cases(root: Path = ROOT) -> list[tuple[Path, dict]]:
    cases: list[tuple[Path, dict]] = []
    for path in sorted((root / "fixtures").rglob("*.json")):
        with path.open("r", encoding="utf-8") as handle:
            case = json.load(handle)
        # Project/package manifests also use JSON under fixtures; they are inputs, not test cases.
        if "kind" not in case:
            continue
        cases.append((path, case))
    return cases


def check_process(proc: subprocess.CompletedProcess[str], case: dict, prefix: str = "") -> list[str]:
    failures: list[str] = []
    expected_exit = case.get(f"{prefix}exit", 0)
    if proc.returncode != expected_exit:
        failures.append(f"{prefix}exit {proc.returncode} != {expected_exit}")
        if proc.stdout:
            failures.append(f"{prefix}stdout {proc.stdout!r}")
        if proc.stderr:
            failures.append(f"{prefix}stderr {proc.stderr!r}")

    exact_stdout = case.get(f"{prefix}stdout")
    if exact_stdout is not None and proc.stdout != exact_stdout:
        failures.append(f"{prefix}stdout {proc.stdout!r} != {exact_stdout!r}")
    exact_stderr = case.get(f"{prefix}stderr")
    if exact_stderr is not None and proc.stderr != exact_stderr:
        failures.append(f"{prefix}stderr {proc.stderr!r} != {exact_stderr!r}")

    for needle in case.get(f"{prefix}stdout_contains", []):
        if needle not in proc.stdout:
            failures.append(f"{prefix}stdout missing {needle!r}")
    for needle in case.get(f"{prefix}stderr_contains", []):
        if needle not in proc.stderr:
            failures.append(f"{prefix}stderr missing {needle!r}")
    return failures


def validate_case(case: dict) -> list[str]:
    failures: list[str] = []
    kind = case.get("kind")
    if kind in {"compile", "compile_fail"}:
        misplaced = sorted(PROCESS_EXPECTATIONS.intersection(case))
        if misplaced:
            failures.append(
                "compile cases must use compile_/run_ expectation keys; misplaced: "
                + ", ".join(misplaced)
            )
    for key, value in case.items():
        if key.endswith(("stdout_contains", "stderr_contains")):
            if not isinstance(value, list) or not all(isinstance(item, str) for item in value):
                failures.append(f"{key} must be a list of strings")
    return failures


def run_cli_case(compiler_cmd: Sequence[str], case: dict) -> tuple[bool, str]:
    proc = run_process([*compiler_cmd, *case.get("args", [])], cwd=ROOT, text=True, capture_output=True, check=False)
    failures = check_process(proc, case)
    return (not failures, "; ".join(failures))


def run_compile_case(compiler_cmd: Sequence[str], case_path: Path, case: dict) -> tuple[bool, str]:
    source = (case_path.parent / case["source"]).resolve()
    if not source.exists():
        return False, f"source fixture not found: {source}"

    with tempfile.TemporaryDirectory(prefix="strut-regression-") as tmp:
        artifact = Path(tmp) / case.get("artifact", "program")
        compile_args = [arg.replace("{source}", str(source)).replace("{artifact}", str(artifact))
                        for arg in case.get("compile_args", ["{source}", "-o", "{artifact}"])]
        proc = run_process([*compiler_cmd, *compile_args], cwd=ROOT, text=True, capture_output=True, check=False)
        failures = check_process(proc, case, "compile_")
        if failures:
            return False, "; ".join(failures)

        if not case.get("run", False):
            return True, ""
        if not artifact.exists() and os.name == "nt":
            exe_artifact = artifact.with_suffix(".exe")
            if exe_artifact.exists():
                artifact = exe_artifact
        if not artifact.exists():
            return False, f"compiler succeeded but artifact was not created: {artifact}"

        raw_run_command = case.get("run_command", ["{artifact}"])
        run_command = [arg.replace("{artifact}", str(artifact)) for arg in raw_run_command]
        run_env = os.environ.copy()
        replacements = {
            "{artifact}": str(artifact),
            "{fixture_dir}": str(case_path.parent.resolve()),
            "{python}": sys.executable,
            "{tmp}": str(Path(tmp).resolve()),
        }
        for key, value in case.get("run_env", {}).items():
            rendered = value
            for marker, replacement in replacements.items():
                rendered = rendered.replace(marker, replacement)
            run_env[key] = rendered
        run_proc = run_process(run_command, cwd=tmp, text=True, capture_output=True, check=False, env=run_env)
        run_failures = check_process(run_proc, case, "run_")
        return (not run_failures, "; ".join(run_failures))



def run_incremental_case(compiler_cmd: Sequence[str], case_path: Path, case: dict) -> tuple[bool, str]:
    import shutil, time
    with tempfile.TemporaryDirectory(prefix="strut-incremental-") as tmp_s:
        root=Path(tmp_s)
        for name in [*case.get("sources",[]),case["dependency"]]: shutil.copy2(case_path.parent/name,root/name)
        init=run_process([*compiler_cmd,"init"],cwd=root,text=True,capture_output=True,check=False)
        if init.returncode!=0: return False,f"init failed: {init.stderr}"
        mtimes={}
        for src in case["sources"]:
            out=root/Path(src).stem
            proc=run_process([*compiler_cmd,src,"-o",str(out),"--verbose"],cwd=root,text=True,capture_output=True,check=False)
            if proc.returncode!=0: return False,f"initial {src} failed: {proc.stderr}"
            obj=root/".strut"/"obj"/"native"/"debug"/(Path(src).stem+ (".obj" if os.name=="nt" else ".o"))
            mtimes[src]=obj.stat().st_mtime_ns
        a=case["sources"][0]; out=root/Path(a).stem
        proc=run_process([*compiler_cmd,a,"-o",str(out),"--verbose"],cwd=root,text=True,capture_output=True,check=False)
        if proc.returncode!=0 or "reuse " not in proc.stdout: return False,"unchanged object was not reused"
        time.sleep(1.05); dep=root/case["dependency"]; dep.touch()
        changed=[]
        for src in case["sources"]:
            out=root/Path(src).stem
            proc=run_process([*compiler_cmd,src,"-o",str(out),"--verbose"],cwd=root,text=True,capture_output=True,check=False)
            if proc.returncode!=0: return False,f"rebuild {src} failed: {proc.stderr}"
            obj=root/".strut"/"obj"/"native"/"debug"/(Path(src).stem+ (".obj" if os.name=="nt" else ".o"))
            changed.append(obj.stat().st_mtime_ns != mtimes[src])
        if changed != [True,False]: return False,f"expected only first object to rebuild, got {changed}"
        return True,""


def run_formatter_case(compiler_cmd: Sequence[str], case_path: Path, case: dict) -> tuple[bool, str]:
    import shutil
    with tempfile.TemporaryDirectory(prefix="strut-format-") as tmp_s:
        root = Path(tmp_s)
        source = root / case["source"]
        source.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(case_path.parent / case["source"], source)
        proc = run_process([*compiler_cmd, "fmt", str(source)], text=True, capture_output=True, check=False)
        if proc.returncode != 0:
            return False, f"fmt failed: {proc.stderr}"
        first = source.read_text(encoding="utf-8")
        expected = (case_path.parent / case["expected"]).read_text(encoding="utf-8")
        if first != expected:
            return False, f"formatted output did not match expected: {first!r}"
        proc2 = run_process([*compiler_cmd, "fmt", "--check", str(source)], text=True, capture_output=True, check=False)
        if proc2.returncode != 0:
            return False, "formatter was not idempotent/clean under --check"
        return True, ""


def run_project_case(compiler_cmd: Sequence[str], case_path: Path, case: dict) -> tuple[bool, str]:
    import shutil
    with tempfile.TemporaryDirectory(prefix="strut-project-") as tmp_s:
        root = Path(tmp_s)
        project_dir = case_path.parent / case["project"]
        shutil.copytree(project_dir, root / "project")
        project = root / "project"
        env = os.environ.copy()
        if case.get("isolated_strut_home", True):
            env["STRUT_HOME"] = str(root / "strut-home")
        for step in case.get("steps", []):
            args = [str(a).replace("{project}", str(project)).replace("{tmp}", str(root)) for a in step.get("args", [])]
            proc = run_process([*compiler_cmd, *args], cwd=project, text=True, capture_output=True, check=False, env=env)
            failures = check_process(proc, step)
            if failures:
                return False, f"step {args}: {'; '.join(failures)}"
        run_artifact = case.get("run_artifact")
        if run_artifact:
            artifact = project / run_artifact
            if not artifact.exists() and os.name == "nt":
                exe_artifact = artifact.with_suffix(".exe")
                if exe_artifact.exists():
                    artifact = exe_artifact
            if not artifact.exists():
                return False, f"project artifact not found: {artifact}"
            proc = run_process([str(artifact)], cwd=project, text=True, capture_output=True, check=False, env=env)
            failures = check_process(proc, case, "run_")
            if failures:
                return False, "; ".join(failures)
        return True, ""

def run_case(compiler_cmd: Sequence[str], path: Path, case: dict) -> tuple[bool, str]:
    validation_failures = validate_case(case)
    if validation_failures:
        return False, "; ".join(validation_failures)
    kind = case.get("kind")
    if kind == "cli":
        return run_cli_case(compiler_cmd, case)
    if kind in {"compile", "compile_fail"}:
        return run_compile_case(compiler_cmd, path, case)
    if kind == "incremental":
        return run_incremental_case(compiler_cmd, path, case)
    if kind == "formatter":
        return run_formatter_case(compiler_cmd, path, case)
    if kind == "project":
        return run_project_case(compiler_cmd, path, case)
    return False, f"unsupported case kind {kind!r}"


def main() -> int:
    parser = argparse.ArgumentParser(description="Run independent Strut regressions")
    parser.add_argument("--compiler", type=Path, default=os.environ.get("STRUT_BIN"))
    parser.add_argument("--filter", default="", help="run only cases whose name/path contains this substring")
    parser.add_argument("--jobs", type=int, default=1, help="run independent cases in parallel")
    parser.add_argument("--timeout", type=float, default=90.0, help="per subprocess timeout in seconds")
    args = parser.parse_args()

    if args.compiler is None:
        parser.error("--compiler or STRUT_BIN is required")
    global PROCESS_TIMEOUT
    PROCESS_TIMEOUT = args.timeout
    compiler = args.compiler.resolve()
    if not compiler.exists():
        parser.error(f"compiler not found: {compiler}")

    cases = load_cases()
    if args.filter:
        needle = args.filter.lower()
        cases = [(p, c) for p, c in cases if needle in c.get("name", p.stem).lower() or needle in str(p).lower()]
    if not cases:
        print("no regression cases found", file=sys.stderr)
        return 2

    def execute(item):
        path, case = item
        try:
            ok, message = run_case([str(compiler)], path, case)
        except subprocess.TimeoutExpired as exc:
            return path, case, False, f"timeout after {exc.timeout}s"
        except Exception as exc:
            return path, case, False, f"runner exception: {exc}"
        return path, case, ok, message

    if args.jobs < 1:
        parser.error("--jobs must be >= 1")
    if args.jobs == 1:
        results = [execute(item) for item in cases]
    else:
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            results = list(pool.map(execute, cases))

    failed = 0
    for path, case, ok, message in results:
        if ok:
            print(f"PASS {case.get('name', path.stem)}")
        else:
            print(f"FAIL {case.get('name', path.stem)}: {message}")
            failed += 1

    print(f"{len(cases) - failed} passed, {failed} failed")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
