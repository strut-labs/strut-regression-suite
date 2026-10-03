struct Parser {
    private string input;
    function parse() -> string { return normalize(); }
    private function normalize() -> string { return this.input + "!"; }
}
function main() -> int {
    Parser p := Parser {};
    if (p.parse() != "!") { return 1; }
    return 0;
}
