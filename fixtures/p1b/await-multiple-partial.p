error A {
    string message;
}
error B {
    string message;
}
async function fetch() -> int : (A, B) {
    return 1;
}
function main() -> int : A {
    x := await fetch();
    return x;
}
