include <filesystem>;
function main() -> int : (HttpError, SqliteError, FilesystemError) {
    sqlite_db db := sqlite_open(":memory:");
    db.exec("CREATE TABLE values_table(value INTEGER)");
    write_file("runtime-components.txt", "composed");
    response := http_get("http://127.0.0.1:9/");
    print(response.status);
    remove("runtime-components.txt");
    return 0;
}
