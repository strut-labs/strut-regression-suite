function main() -> void : SqliteError {
    sqlite_db db := sqlite_open(":memory:");
    db.exec("CREATE TABLE todo(id INTEGER, text TEXT)");
    db.exec("INSERT INTO todo VALUES (?, ?)", json.parse("[1,\"hello\"]"));
    rows := db.query("SELECT text FROM todo WHERE id = ?", json.parse("[1]"));
    print(json.stringify(rows));
    return;
}
