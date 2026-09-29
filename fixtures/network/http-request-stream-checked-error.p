function inspect(string url) -> int {
    head := http_request_stream("GET", url, {}, null, null);
    return head.status;
}

function main() -> int {
    return 0;
}
