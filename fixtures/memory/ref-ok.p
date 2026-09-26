function bump(int& x) -> void {
    *x += 1;
    return;
}
function main() -> void {
    int* p := ptr(7);
    int& r := ref(*p);
    bump(r);
    print(*p);
    return;
}
