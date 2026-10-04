error HttpError {
    string message;
}
async function fetch_data() -> int : HttpError { return 0; }
function consume(future<int> f) -> int { return 0; }
function main() -> int {
    f := fetch_data();
    return consume(f);
}