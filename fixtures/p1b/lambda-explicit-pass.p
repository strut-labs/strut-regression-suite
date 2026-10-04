error Error {
    string message;
}
error IOError {
    string message;
}
error ParseError {
    string message;
}
function main() -> int : IOError {
    f := () : IOError => {
        throw IOError("x");
    };
    return 0;
}