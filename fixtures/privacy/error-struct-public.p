error AppError { string message; int code; }
function main() -> void {
    AppError e := AppError { message: "x", code: 1 };
    print(e.message);
    return;
}
