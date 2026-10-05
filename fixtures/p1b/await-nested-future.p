error A {
    string message;
}
error B {
    string message;
}
function inspect(future<future<int : A> : B> outer) -> int : B {
    inner := await outer;
    value := await inner;
    return value;
}
function main() -> int {
    return 0;
}
