struct Parent { ptr<Child> child; }
struct Child { ptr<Parent> parent; }
function main() -> void { return; }
