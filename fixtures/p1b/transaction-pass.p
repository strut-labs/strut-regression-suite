error Error {
    string message;
}
function main() -> int : SqliteError {
    database := sqlite_open(":memory:");
    database.transaction(() => {
        try {
            throw Error("boom");
        } catch (Error e) {
            print("caught");
        }
    });
    return 0;
}