function main() -> void {
    ptr<int> p := ptr(7);
    unsafe {
        raw_ptr<int> r := raw(p);
        print(*r);
        *r = 9;
        print(*p);
    }
    return;
}
