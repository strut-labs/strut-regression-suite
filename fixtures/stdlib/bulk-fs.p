include <vector>;
include <filesystem>;
function main() -> void : FilesystemError {
    remove_all("strut-bulk-src"); remove_all("strut-bulk-dst"); remove_all("strut-bulk-moved");
    make_dir("strut-bulk-src"); make_dir("strut-bulk-dst"); make_dir("strut-bulk-moved");
    touch("strut-bulk-src/a.txt"); touch("strut-bulk-src/b.txt");
    string[] paths := ["strut-bulk-src/a.txt", "strut-bulk-src/b.txt"];
    copy(paths, "strut-bulk-dst");
    move(paths, "strut-bulk-moved");
    print(exists("strut-bulk-dst/a.txt"));
    print(exists("strut-bulk-moved/b.txt"));
    string[] cleanup := ["strut-bulk-src", "strut-bulk-dst", "strut-bulk-moved"];
    remove_all(cleanup);
    return;
}
