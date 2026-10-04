error AppError {
    string message;
}
function read_file(string path) -> int : AppError { return 0; }
function main() -> int : AppError {
    result := read_file("x");
    return result;
}