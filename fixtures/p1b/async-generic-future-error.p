error AppError {
    string message;
}
async function fetch[T](T value) -> T : AppError { return value; }
function consume_plain(future<int> f) -> int { return 0; }
function main() -> int {
    f := fetch(1);
    return consume_plain(f);
}