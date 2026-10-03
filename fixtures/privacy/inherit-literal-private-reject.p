struct Base {
    private int secret;
    int visible;
}
struct Derived : Base {
    string name;
}
function main() -> int {
    Derived d := Derived { secret: 7, visible: 1, name: "x" };
    return 0;
}
