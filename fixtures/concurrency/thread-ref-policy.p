function main() -> void {
    value := 1;
    r := ref(value);
    worker := thread((ref<int> x) => { print(*x); }, r);
    return;
}
