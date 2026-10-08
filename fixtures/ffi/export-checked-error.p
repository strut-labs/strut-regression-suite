error MyError { string message; }
export "C" function risky() -> string : MyError {
    throw MyError { message: "x" };
}
