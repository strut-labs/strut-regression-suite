struct Counter {
    private int value;
    function current() -> int { return this.value; }
}
function main() -> int {
    Counter* p := new(Counter {});
    unsafe {
        int v := p->value;
        return v;
    }
    return 0;
}
