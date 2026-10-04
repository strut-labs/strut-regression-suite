error Error {
    string message;
}
error IOError {
    string message;
}
function may_fail() -> int : IOError { throw IOError("x"); }
function main() -> int {
    f := () => {
        try {
            may_fail();
        } catch (IOError e) {
            print("caught");
        }
    };
    return 0;
}