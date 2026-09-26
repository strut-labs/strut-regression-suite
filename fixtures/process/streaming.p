include <vector>;
function main() -> void : ExecError {
    program := env("STRUT_TEST_PYTHON") ?? "";
    script := env("STRUT_TEST_HELPER") ?? "";
    p := process(program, [script]);
    p.in.write_line("hello");
    p.in.close();
    out_line := p.out.read_line();
    err_line := p.err.read_line();
    code := p.wait();
    print(out_line);
    print(err_line);
    print(code);
    return;
}
