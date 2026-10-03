struct Base {
    private int secret;
    function get() -> int { return this.secret; }
}
struct Derived : Base {
    function leak() -> int { return secret; }
}
function main() -> int {
    Derived d := Derived {};
    return d.leak();
}
