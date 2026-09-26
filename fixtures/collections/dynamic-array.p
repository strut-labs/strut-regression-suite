include <vector>;
function main() -> void {
    int[] xs := [1, 2, 3];
    xs.push(4);
    for (x : xs) { print(x); }
    print(xs.length());
    xs.pop();
    print(xs[0]);
    return;
}
