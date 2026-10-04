function accepts_plain(future<http_response> f) -> void {
}
function main() -> int {
    f := http_get_async("https://example.com");
    accepts_plain(f);
    return 0;
}