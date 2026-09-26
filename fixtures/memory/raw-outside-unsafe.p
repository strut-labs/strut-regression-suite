function main() -> void {
    int* p := ptr(7);
    ptr<int> r := raw(p);
    print(*r);
    return;
}
