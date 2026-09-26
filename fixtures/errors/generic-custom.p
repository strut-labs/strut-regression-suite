error GenericError { string message; int code; }
function fail[T](T value) -> T : GenericError {
    throw GenericError { message: "generic", code: 7 };
}
function main() -> int {
    try { result := fail(42); println(result); }
    catch (GenericError err) { println(err.message); println(err.code); }
    return 0;
}
