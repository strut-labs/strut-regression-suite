struct User { string name; }
function main() -> void {
    owner := new(User { name: "Ada" });
    unsafe {
        ptr<User> raw_user := ptr(owner);
        print(raw_user->name);
    }
}
