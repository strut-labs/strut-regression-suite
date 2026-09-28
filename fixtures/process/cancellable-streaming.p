function main() -> void : (ExecError, ThreadError, TimeError) {
    program := env("STRUT_TEST_PYTHON") ?? "";
    script := env("STRUT_TEST_CANCELLATION_HELPER") ?? "";

    cancellation_source read_source;
    reader := new(process(program, [script, "sleep"], read_source.token()));
    channel<bool> read_result;
    read_worker := thread(() => {
        try {
            reader->out.read_bytes(1);
            read_result.send(false);
        } catch (ExecError caught) {
            read_result.send(caught.code == 125 && caught.message == "process I/O cancelled");
        }
    });
    sleep_ms(50);
    read_source.cancel();
    print(read_result.receive() ?? false);
    read_worker.join();
    reader->terminate();
    reader->wait();

    cancellation_source write_source;
    writer := new(process(program, [script, "sleep"], write_source.token()));
    bytes payload := bytes(16777216);
    channel<bool> write_result;
    write_worker := thread(() => {
        try {
            writer->in.write_bytes(payload);
            write_result.send(false);
        } catch (ExecError caught) {
            write_result.send(caught.code == 125 && caught.message == "process I/O cancelled");
        }
    });
    sleep_ms(50);
    write_source.cancel();
    print(write_result.receive() ?? false);
    write_worker.join();
    writer->terminate();
    writer->wait();
}
