function main() -> void : NetworkError {
    listener := tcp_listen("127.0.0.1", 19437);
    listener.close();
    return;
}
