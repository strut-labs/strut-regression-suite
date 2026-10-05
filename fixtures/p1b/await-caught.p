error AppError {
    string message;
}
async function fetch_data() -> int : AppError {
    return 1;
}
function main() -> int {
    try {
        x := await fetch_data();
    } catch (AppError e) {
    }
    return 0;
}
