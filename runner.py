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
        run_proc = subprocess.run(run_command, text=True, capture_output=True, check=False)
        run_failures = check_process(run_proc, case, "run_")
        return (not run_failures, "; ".join(run_failures))


def run_case(compiler_cmd: Sequence[str], path: Path, case: dict) -> tuple[bool, str]:
    kind = case.get("kind")
    if kind == "cli":
        return run_cli_case(compiler_cmd, case)
    if kind == "compile":
        return run_compile_case(compiler_cmd, path, case)
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
