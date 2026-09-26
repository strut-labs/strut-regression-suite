function main() -> void {
    value := 1;
    r := ref(value);
    worker := thread((int& x) => { print(*x); }, r);
    return;
}
