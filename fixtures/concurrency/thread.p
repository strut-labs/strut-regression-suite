function work(int* value) -> void {
    *value = *value + 1;
    return;
}
function main() -> void : ThreadError {
    value := ptr(4);
    worker := thread(work, value);
    worker.join();
    print(*value);
    second := thread(() => { print("lambda-thread"); });
    second.join();
    return;
}
