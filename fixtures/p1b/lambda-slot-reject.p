error Error {
    string message;
}
error IOError {
    string message;
}
function slot_a(function<() -> int : Error> fn) -> int { return 0; }
function slot_empty(function<() -> int> fn) -> int { return 0; }
function main() -> int : (Error, IOError) {
    g := () : Error => { throw Error("x"); return 0; };
    h := () : (Error, IOError) => { throw Error("x"); return 0; };
    slot_empty(g);
    slot_a(h);
    return 0;
}