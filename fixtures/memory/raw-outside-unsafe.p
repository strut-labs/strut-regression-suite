function main() -> void {
    ptr<int> p := ptr(7);
    raw_ptr<int> r := raw(p);
    print(*r);
    return;
}
