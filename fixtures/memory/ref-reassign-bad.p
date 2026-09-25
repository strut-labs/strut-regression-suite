function main() -> void {
    x := 1;
    y := 2;
    ref<int> r := ref(x);
    r = ref(y);
    return;
}
