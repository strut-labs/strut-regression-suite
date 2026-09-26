error AsyncError { string message; int code; }
async function fail() -> int : AsyncError {
    throw AsyncError { message: "async", code: 8 };
}
function main() -> int {
    try { result := await fail(); println(result); }
    catch (AsyncError err) { println(err.message); println(err.code); }
    return 0;
}
