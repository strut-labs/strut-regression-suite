function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get("/plaintext", (http_request request) => {
        return http_text("Hello, World!");
    });
    server := thread(() => { try { app.listen("127.0.0.1", 18090); } catch (NetworkError e) { } });
    sleep_ms(600);
    response := http_get("http://127.0.0.1:18090/plaintext");
    print(response.status);
    print(response.body);
    app.stop();
    server.join();
    return 0;
}