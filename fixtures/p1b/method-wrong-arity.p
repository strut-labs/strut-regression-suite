error AppError {
    string message;
}
struct Service {
    function run(int x) -> void : AppError;
}
function Service::run(int x) -> void : AppError { return; }
function main() -> int : AppError {
    s := Service {};
    s.run();
    return 0;
}