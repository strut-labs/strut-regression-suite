function main() -> void : (EnvironmentError, TimeError) {
    set_env("STRUT_CP58_TEST", "works");
    value := env("STRUT_CP58_TEST");
    print(value ?? "missing");
    before := now_ms();
    sleep_ms(1);
    after := now_ms();
    print(after >= before);
    print(unix_ms() > 0);
    unset_env("STRUT_CP58_TEST");
    print(env("STRUT_CP58_TEST") ?? "gone");
    return;
}
