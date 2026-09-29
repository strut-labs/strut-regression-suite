function inspect(http_request request) -> string : HttpError {
    string[] tags := request.query_values.values("tag");
    string? session := request.cookies.get("session");
    present := request.cookies.has("session");
    form := request.form(1024);
    parsed := request.json();
    return request.text();
}

function make_response() -> http_server_response : HttpError {
    cookie := http_cookie("session", "abc");
    cookie.path = "/";
    cookie.domain = "example.com";
    cookie.max_age = 3600;
    cookie.expires = "Wed, 21 Oct 2030 07:28:00 GMT";
    cookie.secure = true;
    cookie.http_only = true;
    cookie.same_site = "Strict";
    response := http_redirect("/next", 303);
    response.cookies = [cookie];
    return response;
}

function stream_cookie(http_response_writer writer, http_cookie cookie) -> void : NetworkError {
    writer.cookie(cookie);
}

function main() -> int {
    return 0;
}
