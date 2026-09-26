include <vector>;
function main() -> void {
    int[] xs := [1,2,3,4];
    ys := xs.map((x) => x * 2);
    zs := ys.filter((x) => x > 4);
    print(zs[0]);
    print(xs.reduce((a,b) => a + b));
    print(xs.any((x) => x == 3));
    print(xs.all((x) => x > 0));
    print(xs.find((x) => x == 4) ?? 0);
    print(xs.count((x) => x > 2));
    xs.sort((a,b) => a > b);
    print(xs[0]);
    return;
}
