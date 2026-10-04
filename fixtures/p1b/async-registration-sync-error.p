function main() -> int {
    app := http_server();
    app.get_async("/x", async (http_request req) => { return http_server_response(200); });
    return 0;
}