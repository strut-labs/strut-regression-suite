atomic<bool> stop := false;

function wait_for_stop() -> void {
    while (!stop.load()) {
    }
    return;
}

function main() -> int : ThreadError {
    worker := thread(wait_for_stop);
    stop.store(true);
    worker.join();
    println(stop.load());
    return 0;
}
