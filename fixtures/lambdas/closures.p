function main() -> void {
    base := 10;
    function<(int)->int> add_base := (x) => x + base;
    print(add_base(5));
    max := (T x, T y) => { if (x > y) { return x; } return y; };
    print(max(2,7));
    return;
}
