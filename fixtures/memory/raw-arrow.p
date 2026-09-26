struct User { string name; }
function main() -> void {
    owner := ptr(User { name: "Ada" });
    unsafe {
        ptr<User> raw_user := raw(owner);
        print(raw_user->name);
    }
}
