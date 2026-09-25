function main() -> void {
    ptr<int> p := ptr(7);
    *p = 8;
    print(*p);
    const ptr<int> q := p;
    print(*q);
    ptr<const int> r := p;
    print(*r);
    return;
}
