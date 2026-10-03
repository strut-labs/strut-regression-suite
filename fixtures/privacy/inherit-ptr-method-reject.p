struct Base {
    private int secret;
    private function helper() -> int { return this.secret + 1; }
    function get() -> int { return this.secret; }
}
struct Derived : Base {
    string name;
}
function main() -> int {
    Derived* p := new(Derived { name: "x" });
    return p->helper();
}
