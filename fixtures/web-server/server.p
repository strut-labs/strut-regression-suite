function main() -> void : NetworkError {
    http_server app := http_server();
    app.get("/hello/:name", (http_request req) => {
        return http_text("hello");
    });
    return;
}
