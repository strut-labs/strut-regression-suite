function accepts_http(future<http_response : HttpError> f) -> void {
}
function main() -> int {
    f := http_get_async("https://example.com");
    accepts_http(f);
    return 0;
}