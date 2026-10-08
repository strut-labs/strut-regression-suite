error E { string message; }
export "C" function f(function<(int_32)->int_32 : E> cb) -> void {
    return;
}
