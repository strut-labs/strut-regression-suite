error AppError {
    string message;
}
async function fetch_data() -> int : AppError {
    return 1;
}
function main() -> int {
    x := await fetch_data();
    return x;
}
