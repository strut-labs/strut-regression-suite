function add(int a, int b) -> int { return a + b; }
function apply(function<(int,int)->int> f, int a, int b) -> int { return f(a,b); }
function choose() -> function<(int,int)->int> { return add; }
function main() -> void {
    function<(int,int)->int> f := add;
    print(f(2,3));
    print(apply(f,4,5));
    function<(int,int)->int> g := choose();
    print(g(6,7));
    return;
}
