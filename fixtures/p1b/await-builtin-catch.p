function main() -> int {
    try {
        r := await http_get_async("https://example.com");
    } catch (HttpError e) {
    }
    return 0;
}
