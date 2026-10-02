function main() -> void : EmbedError {
    files := embed_dir("fixtures/runtime/embed-assets");
    print(files.length());
    print(files["message.txt"]);
    print(files["nested/child.txt"]);
    return;
}