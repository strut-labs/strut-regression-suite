struct Base {
    private int secret;
    int visible;
    function get() -> int { return this.secret; }
    function set(int v) -> void { this.secret = v; }
}
function main() -> int {
    Base b := Base { visible: 2 };
    b.set(9);
    if (b.get() != 9) { return 1; }
    return 0;
}
