function accepts_plain(future<tcp_socket> f) -> void {
}
function main() -> int : NetworkError {
    listener := tcp_listen("127.0.0.1", 0);
    f := listener.accept_async();
    accepts_plain(f);
    return 0;
}