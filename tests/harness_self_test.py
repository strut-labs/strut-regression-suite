#!/usr/bin/env python3
from __future__ import annotations

import json
from pathlib import Path
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
import runner  # noqa: E402


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


FAKE_COMPILER = r'''from pathlib import Path
import sys

args = sys.argv[1:]
source = Path(args[0])
text = source.read_text(encoding="utf-8")
if "FAIL_COMPILE" in text:
    print(f"{source}:2:5: error: deliberate compile failure", file=sys.stderr)
    raise SystemExit(7)
out = Path(args[args.index("-o") + 1])
out.write_text('print("hello from generated program")\n', encoding="utf-8")
'''


def main() -> int:
    with tempfile.TemporaryDirectory(prefix="strut-harness-selftest-") as tmp_s:
        tmp = Path(tmp_s)
        fake = tmp / "fake_compiler.py"
        fake.write_text(FAKE_COMPILER, encoding="utf-8")
        compiler = [sys.executable, str(fake)]

        ok_source = tmp / "ok.p"
        ok_source.write_text("OK\n", encoding="utf-8")
        ok_case_path = tmp / "ok.json"
        ok_case = {
            "kind": "compile",
            "source": "ok.p",
            "compile_exit": 0,
            "compile_stderr": "",
            "run": True,
            "run_command": [sys.executable, "{artifact}"],
            "run_exit": 0,
            "run_stdout": "hello from generated program\n",
            "run_stderr": "",
        }
        ok, message = runner.run_compile_case(compiler, ok_case_path, ok_case)
        require(ok, f"success/run assertion failed: {message}")

        bad_source = tmp / "bad.p"
        bad_source.write_text("line1\nFAIL_COMPILE\n", encoding="utf-8")
        bad_case_path = tmp / "bad.json"
        bad_case = {
            "kind": "compile",
            "source": "bad.p",
            "compile_exit": 7,
            "compile_stderr_contains": [":2:5:", "deliberate compile failure"],
            "run": False,
        }
        ok, message = runner.run_compile_case(compiler, bad_case_path, bad_case)
        require(ok, f"expected-failure/diagnostic assertion failed: {message}")

        wrong_case = dict(ok_case)
        wrong_case["run_stdout"] = "WRONG\n"
        ok, _ = runner.run_compile_case(compiler, ok_case_path, wrong_case)
        require(not ok, "deliberately wrong expectation did not fail")

    print("regression harness self-test passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
