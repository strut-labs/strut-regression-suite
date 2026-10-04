extern "C" function c_add(int a, int b) -> int;
function use(function<(int,int)->int> fn) -> int { return 0; }
function main() -> int {
    return use(c_add);
}