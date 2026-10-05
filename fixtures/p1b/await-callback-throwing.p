error AppError {
    string message;
}
async function fetch() -> int : AppError {
    return 1;
}
function use_ok(function<() -> int : AppError> cb) -> int : AppError {
    return cb();
}
function main() -> int : AppError {
    return use_ok(() : AppError => await fetch());
}
