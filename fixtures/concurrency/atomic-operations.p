struct State { atomic<bool> ready; }

function main() -> int {
    State state;
    state.ready.store(true);
    atomic<bool> running := true;
    atomic<int> value := 3;
    println(state.ready.load());
    println(running.exchange(false));
    println(running.load());
    println(value.compare_exchange(3, 8));
    println(value.fetch_sub(2));
    println(value.load());
    return 0;
}
