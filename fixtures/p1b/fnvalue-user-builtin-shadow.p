error AppError {
    string message;
}
function read_file(string path) -> int : AppError { return 0; }
function invoke(function<(string)->int : AppError> fn) -> int : AppError { return 0; }
function main() -> int : AppError {
    return invoke(read_file);
}