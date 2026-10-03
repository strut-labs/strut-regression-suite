struct Counter {
    private int value;
    function current() -> int { return this.value; }
}
function main() -> int {
    Counter c := Counter {};
    return c.value;
}
