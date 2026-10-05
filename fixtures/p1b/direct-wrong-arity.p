error AppError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function main() -> int : AppError {
    result := parse();
    return result;
}