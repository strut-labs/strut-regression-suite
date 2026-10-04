error AppError {
    string message;
}
struct Service {
    function run(int value) -> string : AppError;
}
function Service::run(int value) -> int : AppError {
    return 0;
}
function main() -> int : AppError {
    s := Service {};
    result := s.run(1);
    return 0;
}