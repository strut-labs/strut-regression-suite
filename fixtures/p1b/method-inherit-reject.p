error AppError {
    string message;
}
struct Base {
    function run() -> void : AppError {
        throw AppError("x");
        return;
    }
}
struct Derived : Base {
}
function main() -> int {
    d := Derived {};
    d.run();
    return 0;
}