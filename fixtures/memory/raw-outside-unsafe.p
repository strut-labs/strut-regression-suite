function main() -> void {
    int* p := new(7);
    ptr<int> r := ptr(p);
    print(*r);
    return;
}
