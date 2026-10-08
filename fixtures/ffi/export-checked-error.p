error MyError { string message; }
export "C" function risky() -> int : MyError {
    throw MyError { message: "x" };
}
