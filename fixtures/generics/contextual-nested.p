function identity[T](T value) -> T { return value; }
function nested[T](T[] values) -> T[] { return values; }
function main() -> int {
    int[] empty := identity([]);
    int[][] values := nested([[1], [2]]);
    int? maybe := identity(7);
    println(empty.length);
    println(values.length);
    println(maybe ?? 0);
    return 0;
}
