struct Inner {
    private int secret;
    function reveal() -> int { return this.secret; }
    function stamp(int v) -> void { this.secret = v; }
}
struct Wrapper {
    private Inner inner;
    bool ready;
    function init() -> void { inner.stamp(7); ready = true; }
    function value() -> int { return inner.reveal(); }
}
function main() -> int {
    Wrapper w := Wrapper { ready: false };
    w.init();
    if (w.value() != 7) { return 1; }
    return 0;
}
