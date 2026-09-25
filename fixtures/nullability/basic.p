struct User {
    string name;
}
function main() -> void {
    User? user := null;
    print(user?.name ?? "none");
    user = User { name: "Nick" };
    if (user != null) {
        print(user.name);
    }
    return;
}
