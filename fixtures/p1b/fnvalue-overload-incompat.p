error AppError {
    string message;
}
error ParseError {
    string message;
}
function parse(int x) -> int : AppError { return x; }
function parse(string x) -> string : ParseError { return x; }
function use_float(function<(double)->double> fn) -> double { return 0.0; }
function main() -> int {
    return 0;
}
function caller() -> double {
    return use_float(parse);
}