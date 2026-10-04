error AppError {
    string message;
}
error IoErr {
    string message;
}
function pick(int x) -> int : AppError { return x; }
function pick(string x) -> string : IoErr { return x; }
function main() -> int : AppError {
    result := pick("s");
    return result;
}