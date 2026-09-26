include <vector>;
function main() -> void : ExecError {
    program := env("STRUT_TEST_PYTHON") ?? "";
    script := env("STRUT_TEST_HELPER") ?? "";
    cwd := env("STRUT_TEST_CWD") ?? "";

    result := exec(program, [script, "alpha", "two words"], {
        "cwd": cwd,
        "env": {
            "STRUT_CHILD_ENV": "works",
            "EXPECTED_CWD": cwd
        }
    });
    print(result.exit_code);
    print(result.stdout);
    print(result.stderr);

    inherited := exec(program, [script, "inherit"], {"inherit_stdio": true});
    print(inherited.exit_code);
    return;
}
