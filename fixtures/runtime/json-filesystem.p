include <filesystem>;
function main() -> int : FilesystemError {
    payload := {"name":"strut","values":[1,2]};
    write_file("runtime-json.txt", json.stringify(payload));
    parsed := json.parse(read_file("runtime-json.txt"));
    print(parsed["name"]);
    remove("runtime-json.txt");
    return 0;
}
