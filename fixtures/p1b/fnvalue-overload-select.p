error AppError {
    string message;
}
error ParseError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function parse(string x) -> string : ParseError { return x; }
function use_string(function<(string)->string : ParseError> fn) -> string : ParseError { return "s"; }
function main() -> int : ParseError {
    return 0;
}
function caller() -> string : ParseError {
    return use_string(parse);
}