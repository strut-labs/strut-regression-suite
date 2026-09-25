# Strut Regression Suite

Independent black-box regression suite for the Strut compiler and generated programs.

This repository intentionally does not link against Strut compiler internals. It invokes a built compiler exactly as a user or CI job would.

## Run

```sh
python3 runner.py --compiler ../strut/build/strut
```

or set `STRUT_BIN`:

```sh
STRUT_BIN=../strut/build/strut python3 runner.py
```

The harness is Python-standard-library only and uses argv-based process execution for portability across Linux, macOS, and Windows.

See `HANDOVER.md` for the fixture contract and maintenance rules.

## Harness self-test

```sh
python3 tests/harness_self_test.py
```

The self-test uses a temporary fake compiler to certify compile success, generated-program stdout/stderr/exit checks, expected compile failures, diagnostic source locations, and fail-closed expectation handling.
