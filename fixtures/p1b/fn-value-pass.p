error Error {
    string message;
}
error IOError {
    string message;
}
function n() -> int { return 0; }
function ea() -> int : Error { return 0; }
function eab() -> int : (Error, IOError) { return 0; }
function slot_empty(function<() -> int> f) -> int { return 0; }
function slot_a(function<() -> int : Error> f) -> int { return 0; }
function slot_ab(function<() -> int : (Error, IOError)> f) -> int { return 0; }
function main() -> int : (Error, IOError) {
    slot_empty(n);
    slot_a(n);
    slot_ab(n);
    slot_a(ea);
    slot_ab(ea);
    slot_ab(eab);
    return 0;
}