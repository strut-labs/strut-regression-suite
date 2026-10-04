error HttpError {
    string message;
}
async function fetch_data() -> int : HttpError { return 0; }
function consume_http(function<() -> future<int : HttpError>> fn) -> int { return 0; }
function main() -> int {
    f := fetch_data;
    return consume_http(f);
}