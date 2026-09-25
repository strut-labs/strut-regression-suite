struct IOError { string message; }
function risky() -> void : IOError { throw IOError("bad"); }
function wrapper() -> void : (IOError) { risky(); return; }
function main() -> void { return; }
