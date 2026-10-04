error AppError {
    string message;
}
struct Service {
    function run() -> void : AppError;
}
function Service::run() -> void : AppError {
    throw AppError("x");
    return;
}
function main() -> int : AppError {
    service := Service {};
    service.run();
    return 0;
}