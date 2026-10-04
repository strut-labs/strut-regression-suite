error AppError {
    string message;
}
error IoErr {
    string message;
}
struct A {
    function go() -> void : AppError;
    function caller() -> void : AppError;
}
struct B {
    function go() -> void : IoErr;
}
function A::go() -> void : AppError { throw AppError("a"); return; }
function A::caller() -> void : AppError { go(); return; }
function B::go() -> void : IoErr { throw IoErr("b"); return; }
function main() -> int : (AppError, IoErr) {
    a := A {};
    a.caller();
    b := B {};
    b.go();
    return 0;
}