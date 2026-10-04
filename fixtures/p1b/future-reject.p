error Error {
    string message;
}
error IOError {
    string message;
}
async function make_a() -> int : Error { return 0; }
async function make_ab() -> int : (Error, IOError) { return 0; }
function take_plain(future<int> f) -> int { return 0; }
function take_a(future<int : Error> f) -> int { return 0; }
function main() -> int : (Error, IOError) {
    take_plain(make_a());
    take_a(make_ab());
    return 0;
}