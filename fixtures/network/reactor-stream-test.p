function serve(http_request req, http_response_writer writer) -> void {
    try {
        writer.content_type("text/plain");
        writer.write("AAA");
        writer.flush();
        writer.write("BBB");
        writer.finish();
    } catch (NetworkError e) { }
    return;
}

function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get_stream("/ss", serve);
    app.get("/hello", (http_request req) => { return http_text("hello"); });
    server := thread(() => { try { app.listen("127.0.0.1", 18094); } catch (NetworkError e) { } });
    sleep_ms(600);
    stream_body := http_get("http://127.0.0.1:18094/ss");
    print(stream_body.body);
    plain := http_get("http://127.0.0.1:18094/hello");
    print(plain.body);
    app.stop();
    server.join();
    return 0;
}