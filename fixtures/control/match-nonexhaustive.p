enum Status { pending, running }
function main() -> void {
    Status s := Status::pending;
    match (s) { Status::pending => { print("p"); } }
    return;
}
