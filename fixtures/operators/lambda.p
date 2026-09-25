struct Vec { int x; }
operator<(Vec, Vec) -> Vec> + := (a, b) => Vec { x: a.x + b.x };
function main() -> void {
    a := Vec { x: 4 };
    b := Vec { x: 5 };
    c := a + b;
    print(c.x);
    return;
}
