struct Counter { int value; }

operator ++(Counter& x) -> Counter& {
    x.value = x.value + 1;
    return x;
}

operator ++(Counter& x, postfix) -> Counter {
    old := Counter { value: x.value };
    x.value = x.value + 1;
    return old;
}

operator --(Counter& x) -> Counter& {
    x.value = x.value - 1;
    return x;
}

operator --(Counter& x, postfix) -> Counter {
    old := Counter { value: x.value };
    x.value = x.value - 1;
    return old;
}

function main() -> int {
    x := Counter { value: 5 };
    updated_up := ++x;
    previous_up := x++;
    updated_down := --x;
    previous_down := x--;
    println(updated_up.value);
    println(previous_up.value);
    println(updated_down.value);
    println(previous_down.value);
    println(x.value);
    return 0;
}
