struct Counter { int value; }
operator ++(Counter& x) -> Counter& { return x; }
function main() -> int { x := Counter { value: 1 }; x++; return 0; }
