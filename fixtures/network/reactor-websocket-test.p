
function ws_handler(http_request request, websocket socket) -> void {
    try {
        socket.accept();
        socket.write_text("ready");
        socket.close(1000, "done");
    } catch (NetworkError e) { } catch (WebSocketError e) { }
    return;
}

function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.websocket("/ws", ws_handler);
    app.get("/plaintext", (http_request req) => { return http_text("Hello, World!"); });
    server := thread(() => { try { app.listen("127.0.0.1", 18102); } catch (NetworkError e) { } });
    sleep_ms(600);
    plain := http_get("http://127.0.0.1:18102/plaintext");
    print(plain.status);
    print(plain.body);
    app.stop();
    server.join();
    return 0;
}
