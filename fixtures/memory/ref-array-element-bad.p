function main() -> void {
    int[] values := [1, 2, 3];
    int& r := ref(values[0]);
    values.push(4);
    print(*r);
    return;
}
