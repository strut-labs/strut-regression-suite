struct Secret {
    private int value;
    function set(int v) -> void { this.value = v; }
    function get() -> int { return this.value; }
}
function make(int v) -> Secret {
    Secret s := Secret {};
    s.set(v);
    return s;
}
function main() -> int {
    Secret s := make(9);
    if (s.get() != 9) { return 1; }
    return 0;
}
