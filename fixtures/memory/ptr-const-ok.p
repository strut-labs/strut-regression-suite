function main() -> void {
    int* p := new(7);
    *p = 8;
    print(*p);
    const int* q := p;
    print(*q);
    int* const r := p;
    print(*r);
    return;
}
