function bump(ref<int> x) -> void {
    *x += 1;
    return;
}
function main() -> void {
    ptr<int> p := ptr(7);
    ref<int> r := ref(*p);
    bump(r);
    print(*p);
    return;
}
