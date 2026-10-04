error Error {
    string message;
}
function consume(function<() -> void> fn) -> void {
    fn();
}
function main() -> int {
    try {
        consume(() => {
            throw Error("boom");
        });
    } catch (Error e) {
    }
    return 0;
}