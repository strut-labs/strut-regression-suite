include <filesystem>;
include <list>;
include <set>;
function main() -> int : FilesystemError {
    remove_all("strut-iter-src"); remove_all("strut-iter-copy"); remove_all("strut-iter-move");
    make_dir("strut-iter-src"); make_dir("strut-iter-copy"); make_dir("strut-iter-move");
    touch("strut-iter-src/a.txt"); touch("strut-iter-src/b.txt"); touch("strut-iter-src/c.txt");
    string[2] fixed := ["strut-iter-src/a.txt", "strut-iter-src/b.txt"];
    copy(fixed, "strut-iter-copy");
    list<string> sources; sources.push("strut-iter-src/c.txt");
    list<string> destinations; destinations.push("strut-iter-move/c.txt");
    move(sources, destinations);
    set<string> cleanup; cleanup.add("strut-iter-copy/a.txt"); cleanup.add("strut-iter-copy/b.txt");
    remove(cleanup);
    print(!exists("strut-iter-copy/a.txt"));
    print(exists("strut-iter-move/c.txt"));
    string[] empty := [];
    remove(empty);
    remove_all("strut-iter-src"); remove_all("strut-iter-copy"); remove_all("strut-iter-move");
    return 0;
}
