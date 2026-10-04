error Error {
    string message;
}
error IOError {
    string message;
}
function slot_a(function<() -> int : Error> fn) -> int { return 0; }
function slot_ab(function<() -> int : (Error, IOError)> fn) -> int { return 0; }
function slot_empty(function<() -> int> fn) -> int { return 0; }
function main() -> int : (Error, IOError) {
    g := () : Error => { throw Error("x"); return 0; };
    h := () : (Error, IOError) => { throw Error("x"); return 0; };
    plain := () => { return 0; };
    slot_a(plain);
    slot_a(g);
    slot_ab(g);
    slot_ab(h);
    return 0;
}