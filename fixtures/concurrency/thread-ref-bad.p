function work(int& value) -> void { return; }
function main() -> void {
    x := 1;
    r := ref(x);
    worker := thread(work, r);
    return;
}
