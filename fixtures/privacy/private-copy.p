struct Counter {
    private int value;
    function current() -> int { return this.value; }
    function increment() -> void { this.value = this.value + 1; }
}
function main() -> int {
    Counter a := Counter {};
    a.increment();
    Counter b := a;
    b.increment();
    if (a.current() != 1) { return 1; }
    if (b.current() != 2) { return 2; }
    return 0;
}
