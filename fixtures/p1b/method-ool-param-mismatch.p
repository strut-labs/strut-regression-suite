struct Service {
    function run(int value) -> void;
}
function Service::run(string value) -> void {
    return;
}
function main() -> int {
    s := Service {};
    s.run(1);
    return 0;
}