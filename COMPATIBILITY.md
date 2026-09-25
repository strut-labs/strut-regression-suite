# Regression compatibility policy

The regression repository is the executable compatibility baseline for released Strut versions.

- Every user-visible language/runtime bug fix should gain a black-box fixture before release.
- Fixtures for supported behaviour are append-only across a stable release line unless the language design audit deliberately removes or changes that behaviour.
- A language-breaking change must update the relevant fixtures and be called out in the compiler compatibility/versioning notes; it must not be hidden by weakening expectations.
- Release tags should record the matching regression-suite commit so an old release can always be re-certified against its original baseline.
- Platform-specific expectations belong in explicit platform fixtures or CI conditions rather than silently accepting different output.
- `compile_fail` cases are first-class compatibility tests: diagnostics may improve, but the unsafe/invalid program must remain rejected unless the language contract changes.

The GitHub Actions workflow is manually dispatchable across Linux x64, macOS arm64 and Windows x64. Linux arm64 compiler certification is configured in the compiler repository separately.
