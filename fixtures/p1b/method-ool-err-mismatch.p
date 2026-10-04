error AppError {
    string message;
}
error IoErr {
    string message;
}
struct Service {
    function run(int value) -> string : AppError;
}
function Service::run(int value) -> string : IoErr {
    return "s";
}
function main() -> int : IoErr {
    s := Service {};
    result := s.run(1);
    return 0;
}