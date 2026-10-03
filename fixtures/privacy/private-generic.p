struct Box[T] {
    private T item;
    bool sealed;
    function put(T value) -> void { this.item = value; }
    function get() -> T { return this.item; }
}
function main() -> int {
    Box<int> b;
    b.put(42);
    if (b.get() != 42) { return 1; }
    if (b.sealed) { return 2; }
    return 0;
}
