struct IOError { string message; }
function risky() -> void : IOError { throw IOError("bad"); }
function main() -> void {
    try {
        risky();
    } catch (IOError err) {
        print("caught");
    }
    return;
}
