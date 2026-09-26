include <filesystem>;
include <vector>;
function main() -> void : FilesystemError {
    string root := "strut-wildcard-fixture";
    remove_all(root);
    make_dir(join_path(root,"src","nested"));
    make_dir(join_path(root,"dest"));
    write_file(join_path(root,"src","a.txt"),"a");
    write_file(join_path(root,"src","b.log"),"b");
    write_file(join_path(root,"src","nested","c.txt"),"c");
    copy(join_path(root,"src","*.txt"), join_path(root,"dest"));
    copy(join_path(root,"src","**","*.txt"), join_path(root,"dest"));
    print(exists(join_path(root,"dest","a.txt")));
    print(exists(join_path(root,"dest","c.txt")));
    remove(join_path(root,"src","*.log"));
    print(exists(join_path(root,"src","b.log")));
    remove_all(root);
}
