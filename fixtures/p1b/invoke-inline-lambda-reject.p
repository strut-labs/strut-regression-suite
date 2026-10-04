error Error {
    string message;
}
function invoke(function<() -> int> fn) -> int { return 0; }
function main() -> int {
    return invoke(() : Error => { throw Error("x"); return 0; });
}