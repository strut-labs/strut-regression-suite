struct Config { int value; }
struct Widget { int value; }
operator :=(Widget dst, Config src) -> void {
    dst.value = src.value;
}
operator =(Widget& dst, Config src) -> void {
    dst.value = src.value;
}
function main() -> void {
    c := Config { value: 7 };
    Widget w := c;
    d := Config { value: 9 };
    w = d;
    print(w.value);
    return;
}
