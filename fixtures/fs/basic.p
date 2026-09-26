include <vector>;
include <filesystem>;
function main() -> void : FilesystemError {
    remove("strut-fs-fixture");
    make_dir("strut-fs-fixture");
    touch("strut-fs-fixture/a.txt");
    print(exists("strut-fs-fixture/a.txt"));
    names := ls("strut-fs-fixture");
    print(names[0]);
    copy("strut-fs-fixture/a.txt", "strut-fs-fixture/b.txt");
    move("strut-fs-fixture/b.txt", "strut-fs-fixture/c.txt");
    print(exists("strut-fs-fixture/c.txt"));
    remove("strut-fs-fixture");
    return;
}
