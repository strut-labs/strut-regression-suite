function main() -> int {
    atomic<string> text := "bad";
    atomic<int> first := 1;
    atomic<int> copied := first;
    return 0;
}
