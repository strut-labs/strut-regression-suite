error AppError {
    string message;
}
error ParseError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function parse(int x) -> string : ParseError { return "s"; }
function use_wrong(function<(int)->string : AppError> fn) -> string : AppError { return "s"; }
function main() -> int : AppError {
    return 0;
}
function caller() -> string : AppError {
    return use_wrong(parse);
}