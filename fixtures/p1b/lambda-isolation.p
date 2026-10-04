error Error {
    string message;
}
error IOError {
    string message;
}
function main() -> int : IOError {
    f := () => {
        throw IOError("x");
    };
    return 0;
}