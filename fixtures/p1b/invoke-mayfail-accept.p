error Error {
    string message;
}
function may_fail() -> int : Error {
    throw Error("boom");
}
function invoke(function<() -> int : Error> fn) -> int : Error {
    return fn();
}
function main() -> int : Error {
    return invoke(may_fail);
}