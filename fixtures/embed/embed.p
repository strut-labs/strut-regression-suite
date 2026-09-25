function main() -> void : EmbedError {
    data := embed_file("fixtures/embed/assets/message.txt");
    print(data);
    return;
}
