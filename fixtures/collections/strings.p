function main() -> void {
    s := " hello ";
    print(s.trim());
    print(s.contains("ell"));
    parts := "a,b,c".split(",");
    print(join(parts, "-"));
    print(to_int("42") + 1);
    print(to_double("2.5"));
    return;
}
