error PolicyError {
    string message;
}
function main() -> int : (NetworkError, PolicyError) {
    app := http_server();
    app.websocket("/error", (http_request request, websocket socket) => {
        throw PolicyError { message: "denied" };
    });
    return 0;
}