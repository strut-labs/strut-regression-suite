function echo_stream(http_request req, http_request_body body, http_response_writer writer) -> void {
    try {
        text := body.read_all_bytes().to_string();
        writer.write(text);
        writer.finish();
    } catch (NetworkError e) { }
    return;
}

function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.post_request_stream("/echo", echo_stream);
    app.get("/plaintext", (http_request req) => { return http_text("Hello, World!"); });
    server := thread(() => { try { app.listen("127.0.0.1", 18096); } catch (NetworkError e) { } });
    sleep_ms(600);
    echo := http_request("POST", "http://127.0.0.1:18096/echo", {"body": "hello"});
    print(echo.status);
    print(echo.body);
    plain := http_get("http://127.0.0.1:18096/plaintext");
    print(plain.body);
    app.stop();
    server.join();
    return 0;
}