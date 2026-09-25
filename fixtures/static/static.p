function main() -> void : (NetworkError, EmbedError) {
    assets := embed_dir("fixtures/embed/assets");
    http_server app := http_server();
    app.static("/", assets, "message.txt");
    return;
}
