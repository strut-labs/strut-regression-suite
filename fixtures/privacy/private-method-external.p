struct Parser {
    private string input;
    function parse() -> string { return parse_internal(); }
    private function parse_internal() -> string { return this.input; }
}
function main() -> int {
    Parser p := Parser {};
    string s := p.parse_internal();
    return 0;
}
