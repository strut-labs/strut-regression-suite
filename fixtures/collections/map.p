function main() -> void {
    map<string, int> scores := ["alice": 10, "bob": 20];
    print(scores["alice"]);
    print(scores.contains("bob"));
    scores.remove("bob");
    print(scores.length());
    return;
}
