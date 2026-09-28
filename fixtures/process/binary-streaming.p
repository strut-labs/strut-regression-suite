include <vector>;
function main() -> void : ExecError {
    program := env("STRUT_TEST_PYTHON") ?? "";
    script := env("STRUT_TEST_BINARY_HELPER") ?? "";
    child := process(program, [script]);
    bytes payload := [0, 1, 127, 128, 255];
    child.in.write_bytes(payload);
    child.in.flush();
    child.in.close();
    bytes result := child.out.read_all_bytes(5);
    int code := child.wait();
    print(result == payload);
    print(child.out.eof());
    print(code);
    child.out.close();
    return;
}
