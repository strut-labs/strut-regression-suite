function main() -> void {
    int* a := new(7);
    int* b := a;
    print(*b);
    b = null;
    print(*a);
    return;
}
