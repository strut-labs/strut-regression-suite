struct A {
    private int secret;
    function read() -> int { return this.secret; }
}
struct B {
    function poke(A a) -> int { return a.secret; }
}
function main() -> int {
    A a := A {};
    B b := B {};
    return b.poke(a);
}
