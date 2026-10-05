error AppError {
    string message;
}
error ParseError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function parse(string x) -> string : ParseError { return x; }
function main() -> int {
    f := parse;
    return 0;
}