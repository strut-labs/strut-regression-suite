function main() -> int : (NetworkError, SqliteError) {
    db := sqlite_open(":memory:");
    app := http_server();
    app.get("/rows", (http_request req) => { return http_json_response(db.query("SELECT 1 AS value")); });
    return 0;
}
