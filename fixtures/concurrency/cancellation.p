cancellation_source source;
cancellation_token token := source.token();

function main() -> void : ThreadError {
    cancellation_token copy := token;
    channel<bool> observed;
    worker := thread(() => {
        copy.wait();
        observed.send(copy.cancelled());
    });
    print(token.cancelled());
    source.cancel();
    source.cancel();
    print(observed.receive() ?? false);
    worker.join();
    try {
        token.throw_if_cancelled();
    } catch (CancellationError caught) {
        print("cancelled");
    }
    return;
}
