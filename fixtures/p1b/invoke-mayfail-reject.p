error Error {
    string message;
}
function may_fail() -> int : Error {
    throw Error("boom");
}
function invoke(function<() -> int> fn) -> int {
    return fn();
}
function main() -> int {
    return invoke(may_fail);
}