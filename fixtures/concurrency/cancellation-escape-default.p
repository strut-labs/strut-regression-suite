channel<cancellation_token> escaped;

function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get("/escape", (http_request request) => {
        escaped.send(request.cancellation);
        return http_text("ok");
    });
    server := thread(() => { try { app.listen("127.0.0.1", 18111); } catch (NetworkError e) { } });
    sleep_ms(600);
    client := thread(() => {
        try {
            r := http_get("http://127.0.0.1:18111/escape");
            print("status", r.status);
        } catch (NetworkError e) { } catch (HttpError e) { }
    });
    cancellation_token none;
    retained := escaped.receive() ?? none;
    client.join();
    query := retained.cancelled();
    print("escaped-ok");
    if (query) { }
    app.stop();
    server.join();
    return 0;
}
