#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent


def load_cases() -> list[tuple[Path, dict]]:
    cases: list[tuple[Path, dict]] = []
    for path in sorted((ROOT / "fixtures").rglob("*.json")):
        with path.open("r", encoding="utf-8") as handle:
            cases.append((path, json.load(handle)))
    return cases


def run_cli_case(compiler: Path, case: dict) -> tuple[bool, str]:
    cmd = [str(compiler), *case.get("args", [])]
    proc = subprocess.run(cmd, text=True, capture_output=True, check=False)
    failures: list[str] = []
    if proc.returncode != case.get("exit", 0):
        failures.append(f"exit {proc.returncode} != {case.get('exit', 0)}")
    for needle in case.get("stdout_contains", []):
        if needle not in proc.stdout:
            failures.append(f"stdout missing {needle!r}")
    if "stderr" in case and proc.stderr != case["stderr"]:
        failures.append(f"stderr {proc.stderr!r} != {case['stderr']!r}")
    return (not failures, "; ".join(failures))


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
        kind = case.get("kind")
        if kind != "cli":
            print(f"FAIL {path.relative_to(ROOT)}: unsupported case kind {kind!r}")
            failed += 1
            continue
        ok, message = run_cli_case(compiler, case)
        if ok:
            print(f"PASS {case.get('name', path.stem)}")
        else:
            print(f"FAIL {case.get('name', path.stem)}: {message}")
            failed += 1

    print(f"{len(cases) - failed} passed, {failed} failed")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
