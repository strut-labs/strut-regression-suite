function main(string cmd, string[] args) -> int {
    println(cmd);
    println(args.length());
    for (arg : args) {
        println(arg);
    }
    return 0;
}
