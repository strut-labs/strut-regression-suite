struct Base {
    private int secret;
    private function helper() -> int { return this.secret + 1; }
    function get() -> int { return this.secret; }
}
struct Derived : Base {
    function leak() -> int { return helper(); }
}
function main() -> int {
    Derived d := Derived {};
    return d.leak();
}
