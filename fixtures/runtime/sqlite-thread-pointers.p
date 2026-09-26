include <vector>;

function main() -> void : (SqliteError, ThreadError) {
    sqlite_db db := sqlite_open(":memory:");
    db.exec("CREATE TABLE values_table(value INTEGER)");
    int* value := new(1);
    vector<int*> values := [value];
    worker := thread(() => { *value = 2; });
    worker.join();
    db.exec("INSERT INTO values_table VALUES (2)");
    print(*values[0]);
    return;
}
