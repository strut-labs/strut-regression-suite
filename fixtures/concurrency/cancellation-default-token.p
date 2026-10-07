function main() -> void {
    cancellation_token t;
    print(t.cancelled());
    try {
        t.throw_if_cancelled();
        print("no-throw");
    } catch (CancellationError caught) {
        print("threw");
    }
    return;
}
