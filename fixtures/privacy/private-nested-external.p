struct Inner {
    private int secret;
    function reveal() -> int { return this.secret; }
}
struct Wrapper {
    private Inner inner;
    bool ready;
}
function main() -> int {
    Wrapper w := Wrapper { ready: true };
    Inner i := w.inner;
    return i.reveal();
}
