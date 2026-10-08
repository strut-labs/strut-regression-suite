struct BadBool {
    int_32 a;
    bool b;
}
export "C" function bad_bool(BadBool v) -> int {
    return 0;
}
