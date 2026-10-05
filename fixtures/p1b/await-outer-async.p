error AppError {
    string message;
}
async function inner() -> int : AppError {
    return 1;
}
async function outer() -> int {
    return await inner();
}
function main() -> int {
    f := outer();
    return 0;
}
