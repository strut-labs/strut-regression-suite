struct Point {
    int x;
}

operator <<(ref<ostream> stream, ref<const Point> point) -> ref<ostream> {
    stream << point.x;
    return stream;
}

function main() -> void : StreamError {
    out << "hello, world!" << endl;
    err << "error-stream" << endl;

    ofstream ofs("strut-console-stream.txt");
    ofs << "line" << endl;
    ofs.close();

    ifstream ifs("strut-console-stream.txt");
    text := ifs.read_all();
    ifs.close();
    out << text;

    p := Point { x: 7 };
    out << p << endl;
    return;
}
