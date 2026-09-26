include <filesystem>;
include <vector>;
function main() -> void : FilesystemError {
    string root := "strut-fs-surface";
    remove_all(root); make_dir(join_path(root,"nested"));
    string p := join_path(root,"nested","a.txt");
    write_file(p,"hello"); append_file(p," world");
    print(read_file(p)); print(is_file(p)); print(is_dir(root)); print(file_size(p));
    print(filename(p)); print(extension(p)); print(stem(p));
    bytes data := read_bytes(p); print(data.length);
    string[] items := walk(root); print(items.length);
    remove_all(root); return;
}
