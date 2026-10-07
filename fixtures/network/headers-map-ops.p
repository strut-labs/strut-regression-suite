include <map>;
function main() -> int : (NetworkError, TimeError, HttpError, ThreadError) {
    app := http_server();
    app.get("/h", (http_request req) => {
        n0 := req.headers.length();
        req.headers.insert("x-added", "added");
        print("val", req.headers["x-added"]);
        n1 := req.headers.length();
        print("grow", n1 - n0);
        req.headers.remove("x-added");
        n2 := req.headers.length();
        print("shrink", n1 - n2);
        print("host", req.headers.contains("host"));
        return http_text("ok");
    });
    server := thread(() => { try { app.listen("127.0.0.1", 18105); } catch (NetworkError e) { } });
    sleep_ms(600);
    m := ["k": "v"];
    print("mv", m["k"]);
    r := http_get("http://127.0.0.1:18105/h");
    print("status", r.status);
    app.stop(); server.join(); return 0;
}
