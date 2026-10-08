struct BadString {
    string s;
}
export "C" function bad_agg(BadString v) -> int {
    return 0;
}
