error Error {
    string message;
}
function main() -> int : SqliteError {
    database := sqlite_open(":memory:");
    database.transaction(() : Error => { throw Error("boom"); });
    return 0;
}