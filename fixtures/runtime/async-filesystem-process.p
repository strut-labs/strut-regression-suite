include <filesystem>;
include <vector>;

async function compute() -> int {
    return 7;
}

function main() -> void : (FilesystemError, ExecError) {
    write_file("composition.txt", "ok");
    result := exec("printf", ["runtime"]);
    pending := compute();
    print(read_file("composition.txt"));
    print(result.stdout);
    print(await pending);
    return;
}
