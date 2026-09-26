function main() -> void {
    int* p := new(7);
    unsafe {
        ptr<int> r := ptr(p);
        print(*r);
        *r = 9;
        print(*p);
    }
    return;
}
