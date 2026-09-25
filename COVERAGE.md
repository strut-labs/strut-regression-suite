# Regression coverage audit — CP92

The independent suite is black-box coverage of shipped Strut behaviour. Compiler unit tests remain separate.

Covered families include lexer/literals, declarations and expressions, control flow, functions/lambdas/generics, arrays/maps/strings/JSON/structs, nullability, pointer/reference/weak/raw memory rules, operators, checked errors, includes/contracts/enums/switch/match, streams/filesystem/processes, threads/mutexes/channels/async, TCP/TLS/HTTP, SQLite, embedding/static serving, formatter, incremental object invalidation, multi-file project builds, and local package resolution.

Negative fixtures intentionally cover malformed lexing, missing semicolons, duplicate declarations, numeric overflow/incompatible assignment, invalid generics, abstract/multiple-base errors, non-exhaustive match, unchecked errors, nullable access, const violations, raw-pointer unsafe boundaries, invalid references, and thread reference policy.

CP92 adds the first whole-project fixture (`strut init` + `strut make`) and package-project fixture (`strut add` + `include <package>`), plus a cross-platform GitHub Actions matrix. Future checkpoints must add at least one black-box fixture for every externally visible feature or bug fix.
