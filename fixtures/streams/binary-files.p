function main() -> void : StreamError {
    bytes payload := [0, 1, 127, 128, 255];
    ofstream output := ofstream("binary-stream.bin", true);
    output.write_bytes(payload);
    output.flush();
    output.close();
    output.close();
    output.flush();

    ifstream input := ifstream("binary-stream.bin", true);
    print(input.eof());
    bytes zero := input.read_bytes(0);
    print(zero.empty());
    print(input.eof());
    bytes first := input.read_bytes(2);
    bytes rest := input.read_all_bytes(3);
    print(first.length());
    print(first[0] == 0);
    print(rest.length());
    print(rest[2] == 255);
    print(input.eof());
    print(input.read_bytes(1).empty());
    input.close();
    input.close();
    return;
}
