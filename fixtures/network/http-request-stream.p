function inspect(string url) -> int : HttpError {
    head := http_request_stream("GET", url, {}, null, null);

    cancellation_source source;
    cancelled_head := http_request_stream("GET", url, {}, null, null, source.token());

    header := head.headers["content-type"];
    return head.status + cancelled_head.status + header.length;
}

function main() -> int {
    return 0;
}
