async function answer() -> int { return 42; }
function main() -> void { f := answer(); x := await f; print(x); return; }
