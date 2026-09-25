struct Shape { function area() -> double; }
function Shape::area() -> double { return 1.0; }
function main() -> void { s := Shape {}; print(s.area()); return; }
