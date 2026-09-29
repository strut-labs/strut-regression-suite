function serve(http_request request, http_response_writer writer) -> void : (FilesystemError, NetworkError) {
    http_serve_file(request, writer, "asset.bin");
    http_serve_file(request, writer, "asset.txt", "text/plain");
}

function main() -> int {
    return 0;
}
