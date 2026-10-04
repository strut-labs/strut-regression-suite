struct Service {
    function helper() -> void;
}
private function Service::helper() -> void {
    return;
}
function main() -> int {
    s := Service {};
    s.helper();
    return 0;
}