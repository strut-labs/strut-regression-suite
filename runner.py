#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from typing import Sequence

ROOT = Path(__file__).resolve().parent


def load_cases(root: Path = ROOT) -> list[tuple[Path, dict]]:
    cases: list[tuple[Path, dict]] = []
    for path in sorted((root / "fixtures").rglob("*.json")):
        with path.open("r", encoding="utf-8") as handle:
            cases.append((path, json.load(handle)))
    return cases


def check_process(proc: subprocess.CompletedProcess[str], case: dict, prefix: str = "") -> list[str]:
    failures: list[str] = []
    expected_exit = case.get(f"{prefix}exit", 0)
    if proc.returncode != expected_exit:
        failures.append(f"{prefix}exit {proc.returncode} != {expected_exit}")

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


def run_cli_case(compiler_cmd: Sequence[str], case: dict) -> tuple[bool, str]:
    proc = subprocess.run([*compiler_cmd, *case.get("args", [])], text=True, capture_output=True, check=False)
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
        proc = subprocess.run([*compiler_cmd, *compile_args], text=True, capture_output=True, check=False)
        failures = check_process(proc, case, "compile_")
        if failures:
            return False, "; ".join(failures)

        if not case.get("run", False):
            return True, ""
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
        run_proc = subprocess.run(run_command, text=True, capture_output=True, check=False, env=run_env)
        run_failures = check_process(run_proc, case, "run_")
        return (not run_failures, "; ".join(run_failures))



def run_incremental_case(compiler_cmd: Sequence[str], case_path: Path, case: dict) -> tuple[bool, str]:
    import shutil, time
    with tempfile.TemporaryDirectory(prefix="strut-incremental-") as tmp_s:
        root=Path(tmp_s)
        for name in [*case.get("sources",[]),case["dependency"]]: shutil.copy2(case_path.parent/name,root/name)
        init=subprocess.run([*compiler_cmd,"init"],cwd=root,text=True,capture_output=True,check=False)
        if init.returncode!=0: return False,f"init failed: {init.stderr}"
        mtimes={}
        for src in case["sources"]:
            out=root/Path(src).stem
            proc=subprocess.run([*compiler_cmd,src,"-o",str(out),"--verbose"],cwd=root,text=True,capture_output=True,check=False)
            if proc.returncode!=0: return False,f"initial {src} failed: {proc.stderr}"
            obj=root/".strut"/"obj"/"native"/"debug"/(Path(src).stem+ (".obj" if os.name=="nt" else ".o"))
            mtimes[src]=obj.stat().st_mtime_ns
        a=case["sources"][0]; out=root/Path(a).stem
        proc=subprocess.run([*compiler_cmd,a,"-o",str(out),"--verbose"],cwd=root,text=True,capture_output=True,check=False)
        if proc.returncode!=0 or "reuse " not in proc.stdout: return False,"unchanged object was not reused"
        time.sleep(1.05); dep=root/case["dependency"]; dep.touch()
        changed=[]
        for src in case["sources"]:
            out=root/Path(src).stem
            proc=subprocess.run([*compiler_cmd,src,"-o",str(out),"--verbose"],cwd=root,text=True,capture_output=True,check=False)
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
        proc = subprocess.run([*compiler_cmd, "fmt", str(source)], text=True, capture_output=True, check=False)
        if proc.returncode != 0:
            return False, f"fmt failed: {proc.stderr}"
        first = source.read_text(encoding="utf-8")
        expected = (case_path.parent / case["expected"]).read_text(encoding="utf-8")
        if first != expected:
            return False, f"formatted output did not match expected: {first!r}"
        proc2 = subprocess.run([*compiler_cmd, "fmt", "--check", str(source)], text=True, capture_output=True, check=False)
        if proc2.returncode != 0:
            return False, "formatter was not idempotent/clean under --check"
        return True, ""

def run_case(compiler_cmd: Sequence[str], path: Path, case: dict) -> tuple[bool, str]:
    kind = case.get("kind")
    if kind == "cli":
        return run_cli_case(compiler_cmd, case)
    if kind == "compile":
        return run_compile_case(compiler_cmd, path, case)
    if kind == "incremental":
        return run_incremental_case(compiler_cmd, path, case)
    if kind == "formatter":
        return run_formatter_case(compiler_cmd, path, case)
    return False, f"unsupported case kind {kind!r}"


def main() -> int:
    parser = argparse.ArgumentParser(description="Run independent Strut regressions")
    parser.add_argument("--compiler", type=Path, default=os.environ.get("STRUT_BIN"))
    args = parser.parse_args()

    if args.compiler is None:
        parser.error("--compiler or STRUT_BIN is required")
    compiler = args.compiler.resolve()
    if not compiler.exists():
        parser.error(f"compiler not found: {compiler}")

    cases = load_cases()
    if not cases:
        print("no regression cases found", file=sys.stderr)
        return 2

    failed = 0
    for path, case in cases:
        ok, message = run_case([str(compiler)], path, case)
        if ok:
            print(f"PASS {case.get('name', path.stem)}")
        else:
            print(f"FAIL {case.get('name', path.stem)}: {message}")
            failed += 1

    print(f"{len(cases) - failed} passed, {failed} failed")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
