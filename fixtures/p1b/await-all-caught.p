error A {
    string message;
}
error B {
    string message;
}
async function fetch() -> int : (A, B) {
    return 1;
}
function main() -> int {
    try {
        x := await fetch();
    } catch (A e) {
    } catch (B e) {
    }
    return 0;
}
