function main(string[] args) -> int {
    println(args.length());
    for (arg : args) {
        println(arg);
    }
    println(program_path() != "");
    return 0;
}
