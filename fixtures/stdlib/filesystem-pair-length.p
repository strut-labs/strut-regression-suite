include <filesystem>;
function main() -> int : FilesystemError {
    string[] sources := [];
    string[] destinations := ["c"];
    try {
        copy(sources, destinations);
    } catch (FilesystemError err) {
        print("length-error");
        return 0;
    }
    return 1;
}
