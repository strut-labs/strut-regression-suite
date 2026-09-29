function inspect(string url) -> int : (HttpError, ThreadError) {
    pending := http_request_stream_async("GET", url, {}, null, null);
    head := await pending;

    cancellation_source source;
    cancelled_pending := http_request_stream_async("GET", url, {}, null, null, source.token());
    cancelled_head := await cancelled_pending;

    header := head.headers["content-type"];
    return head.status + cancelled_head.status + header.length;
}

function main() -> int {
    return 0;
}
