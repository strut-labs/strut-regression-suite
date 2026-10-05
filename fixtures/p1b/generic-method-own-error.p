error AppError {
    string message;
}
struct Box {
    function transform[T](T value) -> T : AppError;
}
function Box::transform[T](T value) -> T : AppError {
    throw AppError("boom");
    return value;
}
function main() -> int : AppError {
    b := Box {};
    result := b.transform(1);
    return result;
}