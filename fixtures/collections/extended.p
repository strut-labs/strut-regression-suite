include <vector>;
include <map>;
function main() -> void {
    int[] xs := [1,2,3,4,5];
    counts := xs.count_by((x) => x % 2);
    print(counts[0]);
    indexed := xs.index_by((x) => x);
    print(indexed[5]);
    parts := xs.partition((x) => x > 3);
    print(parts.matched[0]);
    j := {"a":1,"nested":{"x":1}};
    k := {"b":2,"nested":{"y":2}};
    print(json.stringify(j.pick(["a"])));
    print(json.stringify(j.omit(["a"])));
    print(json.stringify(j.merge_deep(k)));
    return;
}
