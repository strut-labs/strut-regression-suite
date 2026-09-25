struct User {
    int id;
    string name;
    function label() -> string;
}
function User::label() -> string { return name + "#" + to_string(id); }
struct Pair {
    int a;
    int b;
    function sum() -> int { return a + b; }
}
function main() -> void {
    user := User { id: 7, name: "Nick" };
    pair := Pair { a: 2, b: 4 };
    print(user.name);
    print(user.label());
    print(pair.sum());
    return;
}
