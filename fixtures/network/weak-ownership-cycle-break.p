function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := new(http_server());
    weak_handle := weak(app);
    app->get("/shutdown", (http_request request) => {
        server := weak_handle.lock();
        if (server != null) {
            server->stop();
        }
        return http_text("bye");
    });
    server_thread := thread(() => { try { app->listen("127.0.0.1", 18091); } catch (NetworkError e) { } });
    sleep_ms(700);
    response := http_get("http://127.0.0.1:18091/shutdown");
    print(response.status);
    print(response.body);
    server_thread.join();
    return 0;
}
