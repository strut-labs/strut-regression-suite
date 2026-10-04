error Error {
    string message;
}
function may_fail() -> int : Error { throw Error("boom"); }
function identity[T](T value) -> T { return value; }
function invoke_empty(function<() -> int> fn) -> int { return 0; }
function invoke(function<() -> int : Error> fn) -> int : Error { return fn(); }
function main() -> int : Error {
    f := identity(may_fail);
    return invoke(f);
}