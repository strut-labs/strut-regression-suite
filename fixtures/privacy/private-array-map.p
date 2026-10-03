struct Counter {
    private int value;
    function current() -> int { return this.value; }
    function increment() -> void { this.value = this.value + 1; }
}
include <map>;
function main() -> int {
    Counter[] items := [Counter {}, Counter {}];
    items[0].increment();
    items[0].increment();
    items[1].increment();
    if (items[0].current() != 2) { return 1; }
    if (items[1].current() != 1) { return 2; }
    Counter[] copy := items;
    copy[0].increment();
    if (items[0].current() != 2) { return 3; }
    if (copy[0].current() != 3) { return 4; }
    map<string, Counter> counters;
    Counter a := Counter {};
    a.increment();
    counters["a"] = a;
    if (counters["a"].current() != 1) { return 5; }
    return 0;
}
