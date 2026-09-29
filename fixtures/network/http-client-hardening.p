function inspect(string url) -> int : (HttpError, ThreadError) {
    options := {
        "headers": {"Accept": "application/json"},
        "body": "",
        "timeout_ms": 1000,
        "follow_redirects": true,
        "max_redirects": 3,
        "max_request_body_bytes": 1024,
        "max_response_body_bytes": 4096,
        "max_response_header_bytes": 8192,
        "max_response_header_count": 20
    };
    response := http_request("POST", url, options);
    pending := http_request_async("POST", url, options);
    async_response := await pending;
    return response.status + async_response.status;
}

function main() -> int {
    return 0;
}
