enum Status { pending, running, complete }
function main() -> void {
    Status s := Status::running;
    match (s) {
        Status::pending => { print("p"); },
        Status::running => { print("r"); },
        Status::complete => { print("c"); }
    }
    return;
}
