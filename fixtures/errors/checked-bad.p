struct IOError { string message; }
function risky() -> void : IOError { throw IOError("bad"); }
function main() -> void { risky(); return; }
