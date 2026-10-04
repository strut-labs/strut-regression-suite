error Error {
    string message;
}
error IOError {
    string message;
}
function ea() -> int : Error { return 0; }
function eab() -> int : (Error, IOError) { return 0; }
function eb() -> int : IOError { return 0; }
function slot_empty(function<() -> int> f) -> int { return 0; }
function slot_a(function<() -> int : Error> f) -> int { return 0; }
function slot_b(function<() -> int : IOError> f) -> int { return 0; }
function main() -> int : (Error, IOError) {
    slot_empty(ea);
    slot_empty(eab);
    slot_a(eab);
    slot_a(eb);
    return 0;
}