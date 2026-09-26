function main() -> void {
    int* owner := new(7);
    unsafe {
        ptr<int> raw_value := ptr(owner, owner);
    }
    return;
}
