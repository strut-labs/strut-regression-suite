function main() -> int : HttpError {
    body := http_get_json("https://example.invalid/user");
    print(body["name"]);
    return 0;
}
