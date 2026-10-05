error AppError {
    string message;
}
async function fetch() -> int : AppError {
    return 1;
}
function main() -> int {
    try {
        f := () => await fetch();
    } catch (AppError e) {
    }
    return 0;
}
