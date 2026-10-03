struct Base {
    private int secret;
    int visible;
}
struct Derived : Base {
    string name;
}
function main() -> int {
    Derived d := Derived { visible: 3, name: "x" };
    if (d.visible != 3) { return 1; }
    if (d.name != "x") { return 2; }
    return 0;
}
