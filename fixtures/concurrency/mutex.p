function main() -> void : ThreadError {
    mutex m;
    value := new(0);
    a := thread(() => { m.lock(() => { *value = *value + 1; }); });
    b := thread(() => { m.lock(() => { *value = *value + 1; }); });
    a.join(); b.join();
    m.lock(); *value = *value + 1; m.unlock();
    print(*value); return;
}
