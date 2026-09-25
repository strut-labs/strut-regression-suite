struct Box[T] { T value; }
function identity[T](T x) -> T { return x; }
function main() -> void { print(identity(7)); return; }
