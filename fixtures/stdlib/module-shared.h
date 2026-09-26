include <map>;
function shared_value() -> int { map<int,int> m := [1:5]; return m[1]; }
