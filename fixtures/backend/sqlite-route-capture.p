function main() -> int : (NetworkError, SqliteError) {
    db := sqlite_open(":memory:");
    app := http_server();
    app.get("/rows", (http_request req) => { try { return http_json_response(db.query("SELECT 1 AS value")); } catch (SqliteError e) { return http_text("error"); } });
    return 0;
}
