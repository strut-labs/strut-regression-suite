function main() -> void {
    int* a := ptr(7);
    int* b := a;
    print(*b);
    b = null;
    print(*a);
    return;
}
