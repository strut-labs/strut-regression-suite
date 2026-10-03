struct Base {
    private int secret;
    int visible;
    function get() -> int { return this.secret; }
    function twice() -> int { return this.secret * 2; }
}
struct Derived : Base {
    string name;
    function leak() -> int { return visible; }
}
function main() -> int {
    Derived d := Derived { visible: 4, name: "x" };
    if (d.get() != 0) { return 1; }
    if (d.twice() != 0) { return 2; }
    if (d.leak() != 4) { return 3; }
    if (d.visible != 4) { return 4; }
    return 0;
}
