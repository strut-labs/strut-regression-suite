include <tuple>;
function main() -> void {
    tuple<double,int> t := (2.0, 1);
    tuple<int> one := (7,);
    print(t[0]);
    print(t[1]);
    print(one[0]);
}
