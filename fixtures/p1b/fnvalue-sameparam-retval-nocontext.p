error AppError {
    string message;
}
error ParseError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function parse(int x) -> string : ParseError { return "s"; }
function main() -> int {
    f := parse;
    return 0;
}