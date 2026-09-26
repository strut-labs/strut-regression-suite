atomic<int> counter := 0;
function increment() -> void { counter.fetch_add(1); return; }
function main() -> int : ThreadError {
    first := thread(increment);
    second := thread(increment);
    first.join();
    second.join();
    println(counter.load());
    return 0;
}
