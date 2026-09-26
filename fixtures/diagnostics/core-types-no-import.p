function main() -> int {
    int[] values := [1, 2, 3];
    payload := {"values": [1, 2, 3]};
    print(values.length());
    print(payload["values"][0]);
    return 0;
}
