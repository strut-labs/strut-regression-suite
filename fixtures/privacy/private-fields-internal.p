struct Counter {
    private int value;
    string label;
    function current() -> int { return this.value; }
    function increment() -> void { this.value = this.value + 1; }
}
function main() -> int {
    Counter c := Counter { label: "c" };
    c.increment();
    c.increment();
    if (c.current() != 2) { return 1; }
    if (c.label != "c") { return 2; }
    return 0;
}
