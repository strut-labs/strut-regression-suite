function main() -> void : StreamError {
    ofstream ofs("strut-stream.txt");
    ofs.write("hello");
    ofs.close();

    ifstream ifs;
    ifs.open("strut-stream.txt");
    text := ifs.read_all();
    ifs.close();
    print(text);
    return;
}
