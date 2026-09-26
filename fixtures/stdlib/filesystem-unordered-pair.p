include <filesystem>;
include <set>;
function main() -> int : FilesystemError {
    set<string> sources;
    string[] destinations := [];
    copy(sources, destinations);
    return 0;
}
