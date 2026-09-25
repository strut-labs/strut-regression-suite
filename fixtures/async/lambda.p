function main() -> void {
    add := async (int x, int y) => x + y;
    f := add(20, 22); result := await f; print(result); return;
}
