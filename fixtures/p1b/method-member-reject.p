error AppError {
    string message;
}
struct Service {
    function run() -> void : AppError {
        throw AppError("boom");
        return;
    }
}
function main() -> int {
    service := Service {};
    service.run();
    return 0;
}