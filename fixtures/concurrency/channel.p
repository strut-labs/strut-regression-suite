function main() -> void : ThreadError {
    channel<int> jobs;
    worker := thread(() => { jobs.send(7); jobs.close(); });
    value := jobs.receive(); print(value ?? 0); worker.join(); print(jobs.closed()); return;
}
