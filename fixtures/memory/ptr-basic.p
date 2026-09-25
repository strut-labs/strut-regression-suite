function main() -> void {
    ptr<int> a := ptr(7);
    ptr<int> b := a;
    print(*b);
    b = null;
    print(*a);
    return;
}
