error Error {
    string message;
}
function consume(function<() -> void> fn) -> void {
    fn();
}
function main() -> int {
    consume(() => {
        try {
            throw Error("boom");
        } catch (Error e) {
        }
    });
    return 0;
}