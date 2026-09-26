include <map>;

type owners := int*[];

function identity(owners values) -> owners {
    return values;
}

function main() -> void {
    owners values := [];

    map<string, int&> references;
    map<string, int[]>? optional_groups := null;
    vector<function<(int)->int>> callbacks := [];
    function<(map<string, int[]>, int*[])->int> inspect :=
        (map<string, int[]> groups, int*[] pointers) => 0;

    identity(values);
    return;
}
