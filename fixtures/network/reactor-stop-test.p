function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get("/plaintext", (http_request request) => {
        return http_text("Hello, World!");
    });
    server := thread(() => { try { app.listen("127.0.0.1", 18092); } catch (NetworkError e) { } });
    sleep_ms(600);
    for (i := 0; i < 6; i++) {
        try {
            response := http_get("http://127.0.0.1:18092/plaintext");
            print(response.status);
            print(response.body);
        } catch (HttpError e) {
            print("CLIENT_ERROR");
        }
        sleep_ms(20);
    }
    app.stop();
    server.join();
    print("STOP_OK");
    return 0;
}