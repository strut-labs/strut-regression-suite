function main() -> void {
    j := json.parse("{\"x\": [1,2], \"ok\": true}");
    print(j["x"][0]);
    print(json.stringify(j));
    print(json.pretty(j).contains("  \"x\""));
    copy := json.encode(j);
    print(copy == j);
    return;
}
