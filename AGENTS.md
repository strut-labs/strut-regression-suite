# Agent instructions (strut-regression-suite)

Independent black-box regression suite for Strut. It invokes a built `strut` binary exactly as
a user would and must not link against compiler internals.

## Contract

- Add a fixture as soon as a user-visible language/runtime behaviour is implemented or changes.
- Include both success and expected-failure cases; record expected diagnostics for invalid
  programs where message/location is part of the contract.
- Keep fixtures small and focused; use real-project fixtures only for project flows.
- Never silently update expected output to make a case pass — decide whether the compiler or
  the expectation is wrong.
- A change that alters Strut's public behaviour is not complete until the matching fixture
  exists and passes.

## Layout

- `fixtures/<area>/*.p` (source) and `fixtures/<area>/*.json` (expectation). See `README.md`
  and `COVERAGE.md`; `runner.py` is Python-standard-library only.
- Harness self-test: `python3 tests/harness_self_test.py`.

## Workflow

- Run the suite against the built compiler: `python3 runner.py --compiler <strut>` (default and,
  for reactor cases, with `STRUT_HTTP_REACTOR=1`); record the actual totals.
- The Strut release workflow pins this repository by exact commit SHA — when you update the
  suite, the pin in `strut/.github/workflows/release.yml` must be updated to the pushed SHA.
- Keep coverage aligned with Strut's public API registry and release notes; a passing total does
  not prove coverage is complete.
