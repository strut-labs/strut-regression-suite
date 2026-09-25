struct Vec { int x; }
operator +(Vec a, Vec b) -> Vec {
    return Vec { x: a.x + b.x };
}
function main() -> void {
    a := Vec { x: 2 };
    b := Vec { x: 3 };
    c := a + b;
    print(c.x);
    return;
}
