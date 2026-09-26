struct Number { int value; }
operator <<(Number value, int amount) -> Number {
    return Number { value: value.value << amount };
}
operator -(Number value) -> Number {
    return Number { value: -value.value };
}
function main() -> int {
    result := -(Number { value: 1 } << 2);
    println(result.value);
    return 0;
}
