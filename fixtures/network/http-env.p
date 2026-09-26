function main() -> void : HttpError {
    url := env("STRUT_ENDPOINT") ?? "http://127.0.0.1:9/";
    response := http_get(url);
    print(response.status);
    return;
}
