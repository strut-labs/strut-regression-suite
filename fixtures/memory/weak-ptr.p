function main() -> void {
    int* p := new(7);
    weak_ptr<int> w := weak(p);
    q := w.lock();
    print(*q);
    q = null;
    p = null;
    print(w.expired());
    return;
}
