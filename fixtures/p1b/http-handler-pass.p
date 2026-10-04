error Error {
    string message;
}
function main() -> int : NetworkError {
    server := http_server();
    server.get("/", () => {
        try {
            throw Error("boom");
        } catch (Error e) {
            print("caught");
        }
        return http_server_response(200);
    });
    return 0;
}