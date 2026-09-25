async function add(int a, int b) -> int {
    return a + b;
}
function main() -> void {
    first := add(2, 3);
    second := add(4, 5);
    print(await first);
    print(await second);
    return;
}
