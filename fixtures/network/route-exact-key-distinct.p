function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get("/a/bc", (http_request r) => { return http_text("ABC"); });
    app.get("/ab/c", (http_request r) => { return http_text("DEF"); });
    app.get("/a/b/c", (http_request r) => { return http_text("GHI"); });
    app.get("/a", (http_request r) => { return http_text("A"); });
    app.get("/", (http_request r) => { return http_text("ROOT"); });
    server := thread(() => { try { app.listen("127.0.0.1", 18104); } catch (NetworkError e) { } });
    sleep_ms(600);
    p1 := http_get("http://127.0.0.1:18104/a/bc");
    print("p1", p1.body);
    p2 := http_get("http://127.0.0.1:18104/ab/c");
    print("p2", p2.body);
    p3 := http_get("http://127.0.0.1:18104/a/b/c");
    print("p3", p3.body);
    p4 := http_get("http://127.0.0.1:18104/a/");
    print("p4", p4.body);
    p5 := http_get("http://127.0.0.1:18104/");
    print("p5", p5.body);
    p6 := http_get("http://127.0.0.1:18104/abc");
    print("p6", p6.status);
    app.stop();
    server.join();
    return 0;
}
