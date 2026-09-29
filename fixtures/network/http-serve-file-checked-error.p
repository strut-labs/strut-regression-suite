function serve(http_request request, http_response_writer writer) -> void {
    http_serve_file(request, writer, "asset.bin");
}

function main() -> int {
    return 0;
}
