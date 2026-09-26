function main() -> void {
    int* p := ptr(7);
    unsafe {
        ptr<int> r := raw(p);
        print(*r);
        *r = 9;
        print(*p);
    }
    return;
}
