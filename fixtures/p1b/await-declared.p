error AppError {
    string message;
}
async function fetch_data() -> int : AppError {
    return 1;
}
function main() -> int : AppError {
    x := await fetch_data();
    return x;
}
