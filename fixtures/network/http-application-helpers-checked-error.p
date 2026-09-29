function read_body(http_request request) -> void {
    request.text();
}

function redirect() -> http_server_response {
    return http_redirect("/next");
}

function write_cookie(http_response_writer writer, http_cookie cookie) -> void {
    writer.cookie(cookie);
}

function main() -> int {
    return 0;
}
