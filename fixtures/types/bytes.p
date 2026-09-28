function main() -> int {
    bytes empty := bytes();
    bytes value := [0, 1, 127, 128, 255];
    bytes copy := value;
    copy[0] = 9;
    bytes sliced := value.slice(1, 4);
    string raw := value.to_string();
    bytes roundtrip := bytes.from_string(raw);
    print(empty.empty());
    print(value.length());
    print(value[0] == 0);
    print(value[4] == 255);
    print(copy != value);
    print(sliced.length());
    print(roundtrip == value);
    return 0;
}
