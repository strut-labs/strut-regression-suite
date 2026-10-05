error AppError {
    string message;
}
async function fetch() -> int : AppError {
    return 1;
}
function pass_through(future<int : AppError> f) -> future<int : AppError> {
    return f;
}
function main() -> int {
    f := fetch();
    g := pass_through(f);
    x := await g;
    return x;
}
