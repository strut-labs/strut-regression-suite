error ExecError {
    string message;
}
error IoError {
    string message;
}
async function inner() -> int : IoError {
    return 1;
}
function get_future() -> future<int : IoError> : ExecError {
    return inner();
}
function main() -> int : ExecError {
    f := get_future();
    x := await f;
    return x;
}
