function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get("/", (http_request r) => { return http_text("root"); });
    app.get("/a", (http_request r) => { return http_text("a"); });
    app.get("/greet/:name", (http_request r) => { return http_text("hi"); });
    app.get("/x/:p1/y/:p2", (http_request r) => { return http_text("xy"); });
    server := thread(() => { try { app.listen("127.0.0.1", 18103); } catch (NetworkError e) { } });
    sleep_ms(600);
    root := http_get("http://127.0.0.1:18103/");
    print("root", root.status);
    a := http_get("http://127.0.0.1:18103/a");
    print("a", a.status);
    greet := http_get("http://127.0.0.1:18103/greet/bob");
    print("greet", greet.status);
    multi := http_get("http://127.0.0.1:18103/x/1/y/2");
    print("multi", multi.status);
    trailing := http_get("http://127.0.0.1:18103/a/");
    print("trailing", trailing.status);
    miss := http_get("http://127.0.0.1:18103/nope");
    print("miss", miss.status);
    app.stop();
    server.join();
    return 0;
}
