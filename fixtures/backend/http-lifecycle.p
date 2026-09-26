function main() -> int : NetworkError {
    app := http_server();
    app.timeouts(1000, 1000, 1000, 500);
    app.limits(1024, 4096, 20, 8);
    app.get("/health", (http_request request) => { return http_text("ok"); });
    app.stop();
    if (app.running()) {
        return 1;
    }
    return 0;
}
