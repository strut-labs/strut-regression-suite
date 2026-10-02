struct Inner {
    int value;
}

struct Outer {
    Inner inner;
    string name;
}

const int seed := 41;

Outer global_outer := Outer {
    inner: Inner { value: seed },
    name: "x"
};

Inner[] global_items := [
    Inner { value: 7 },
    Inner { value: 8 }
];

json global_json := {
    "tags": ["a", "b"]
};

function main() -> int {
    if (global_outer.inner.value != 41) {
        return 1;
    }
    if (global_outer.name != "x") {
        return 2;
    }
    if (global_items.length() != 2) {
        return 3;
    }
    if (global_items[1].value != 8) {
        return 4;
    }
    return 0;
}