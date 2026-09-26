include <map>;
function main() -> void {
    map<string, int> scores := ["alice": 10, "bob": 20];
    print(scores["alice"]);
    print(scores.contains("bob"));
    scores.remove("bob");
    scores.insert("carol", 30);
    print(scores["carol"]);
    print(scores.length());
    return;
}
