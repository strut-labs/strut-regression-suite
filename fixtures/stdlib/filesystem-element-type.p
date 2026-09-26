include <filesystem>;
function main() -> int : FilesystemError {
    int[] paths := [1, 2];
    remove(paths);
    return 0;
}
