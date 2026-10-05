error AppError {
    string message;
}
error ParseError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function parse(int x) -> string : ParseError { return "s"; }
function main() -> int : (AppError, ParseError) {
    result := parse(1);
    return 0;
}