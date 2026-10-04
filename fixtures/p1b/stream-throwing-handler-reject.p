function main() -> int : NetworkError {
    app := http_server();
    app.get_stream("/after", (http_request request, http_response_writer writer) => {
        writer.write("first");
        throw NetworkError("post-commit");
    });
    return 0;
}