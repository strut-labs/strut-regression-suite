# Regression coverage audit — CP109

The independent suite is black-box coverage of shipped Strut behaviour. Compiler unit tests remain separate and are not a substitute for invoking Strut as a user would.

| Area | Black-box coverage |
| --- | --- |
| Lexing, literals, parser diagnostics | yes |
| Declarations, aliases, expressions, control flow | yes |
| Functions, lambdas, generics, operators | yes |
| Arrays, maps, strings, JSON, structs, enums | yes |
| Bytes, Base64/Base64url, SHA-256, HMAC and secure random | yes |
| Nullability, `ptr`, `ref`, `weak_ptr`, raw/unsafe | yes |
| Checked errors / try-catch | yes |
| Includes, contracts, package includes | yes |
| Filesystem, streams, environment, process APIs | yes |
| Threads, mutexes, channels, async | yes |
| TCP, TLS client, HTTP client buffered/streaming compile surface/server | yes |
| SQLite, embedding, static assets | yes |
| Formatter and CLI workflows | yes |
| Incremental `.o` / `.info.json` invalidation | yes |
| Multi-file project build | yes |
| Local package add/install/include | yes |
| LSP command surface | yes |

Negative fixtures cover malformed lexing, missing semicolons, duplicate declarations, numeric overflow/incompatible assignment, invalid generics, abstract/multiple-base errors, non-exhaustive match, unchecked errors (including the streaming HTTP client's required `HttpError`), malformed/noncanonical Base64, nullable access, const violations, raw-pointer unsafe boundaries, invalid references, and thread-reference policy.

Bounded outbound HTTP transfer behavior is certified against a deterministic local peer in the compiler repository; this independent suite covers its public compile surface and composition. Independent fixtures compile the synchronous and asynchronous `http_request_stream` APIs, `http_response_head` fields, nullable upload/download callbacks, and cancellation-token overloads.

## Real-project fixtures

The suite contains whole-project flows rather than only isolated files:

- `strut init` + `strut make` project build,
- local package add/cache/include/build,
- incremental object invalidation across multiple source/dependency files.

## Execution

`runner.py` remains Python-standard-library only. `--jobs N` allows independent cases to run concurrently, while output remains deterministic in fixture order. `--timeout SECONDS` prevents a hung compiler/generated program from hanging CI indefinitely. A manually dispatchable GitHub Actions matrix runs the black-box suite on Linux x64, macOS arm64 and Windows x64 against a chosen compiler ref.

See `COMPATIBILITY.md` for release-baseline policy.
