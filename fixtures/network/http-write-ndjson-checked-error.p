function emit(http_request request, http_response_writer writer, json value) -> void {
    http_write_ndjson(request, writer, value);
}

function main() -> int {
    return 0;
}
