error AppError {
    string message;
}
struct Service {
    private function helper() -> void;
}
function Service::helper() -> void {
    return;
}
function main() -> int {
    s := Service {};
    s.helper();
    return 0;
}