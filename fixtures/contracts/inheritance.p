struct Printable { function text() -> string; }
struct Named { string name; }
struct User : Named, Printable { function text() -> string { return name; } }
function main() -> void { u := User { name: "Nick" }; print(u.text()); return; }
