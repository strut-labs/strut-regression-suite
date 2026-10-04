struct Box {
    function transform[T](T value) -> T;
}
function Box::transform[T, U](T value) -> U {
    return value;
}
function main() -> int {
    b := Box {};
    result := b.transform(1);
    return 0;
}