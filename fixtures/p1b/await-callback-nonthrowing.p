error AppError {
    string message;
}
async function fetch() -> int : AppError {
    return 1;
}
function use(function<() -> int> cb) -> int {
    return cb();
}
function main() -> int {
    return use(() => await fetch());
}
