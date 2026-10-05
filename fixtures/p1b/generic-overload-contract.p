error AppError {
    string message;
}
error IoErr {
    string message;
}
function pick[T](T value) -> T : AppError { return value; }
function pick(int value) -> int : IoErr { return value; }
function main() -> int : AppError {
    result := pick("x");
    return 0;
}