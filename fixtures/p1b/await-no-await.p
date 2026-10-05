error AppError {
    string message;
}
async function fetch_data() -> int : AppError {
    return 1;
}
function main() -> int {
    f := fetch_data();
    return 0;
}
