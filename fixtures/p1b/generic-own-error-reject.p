error AppError {
    string message;
}
function risky[T](T value) -> T : AppError {
    throw AppError("boom");
}
function main() -> int {
    result := risky(1);
    return 0;
}