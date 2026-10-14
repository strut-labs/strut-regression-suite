function main() -> int : NetworkError {
    app := new(http_server());
    w := weak(app);
    locked := w.lock();
    if (locked != null) {
        print("live");
    }
    print(w.expired());
    return 0;
}
