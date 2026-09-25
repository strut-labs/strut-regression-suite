# Strut Regression Suite Handover

## Purpose

Keep an independent, black-box contract suite separate from compiler unit tests. A compiler refactor that accidentally preserves its own assumptions should still be caught here.

## Fixture shape

Cases are JSON files under `fixtures/`. CP3 begins with CLI smoke cases; language compile/run cases are added as compiler support arrives.

CLI case:

```json
{
  "name": "help",
  "kind": "cli",
  "args": ["--help"],
  "exit": 0,
  "stdout_contains": ["Usage: strut"],
  "stderr": ""
}
```

Future compile cases use a source fixture and declare compile/run expectations. The harness must remain black-box and must never import Strut implementation code.

## Portability

- use `subprocess` with argument arrays, never shell command concatenation;
- use `pathlib` for paths;
- avoid POSIX-only executability assumptions in harness logic;
- keep dependencies to the Python standard library unless a dependency clearly earns its cost.
