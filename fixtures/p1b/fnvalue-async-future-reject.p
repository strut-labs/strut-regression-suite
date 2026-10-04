error HttpError {
    string message;
}
async function fetch_data() -> int : HttpError { return 0; }
function consume_plain(function<() -> future<int>> fn) -> int { return 0; }
function main() -> int {
    f := fetch_data;
    return consume_plain(f);
}