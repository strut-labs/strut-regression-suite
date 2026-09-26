include <vector>;

function main() -> void : (HttpError, ExecError, ThreadError) {
    configured := "http://127.0.0.1:9/";
    started := now_ms();
    child := exec("printf", ["runtime"]);
    total := new(0);
    worker := thread(() => { *total = 1; });
    worker.join();
    response := http_get(configured);
    print(started);
    print(child.stdout);
    print(*total);
    print(response.status);
    return;
}
