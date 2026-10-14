struct Holder { http_server app; }
function main() -> int : NetworkError {
    holder := new(Holder { app: http_server() });
    w := weak(holder);
    locked := w.lock();
    if (locked != null) {
        print("holder-live");
    }
    print(w.expired());
    return 0;
}
