include "module-error.h";
function main() -> int {
    try { value := module_fail(); println(value); }
    catch (ModuleError err) { println(err.message); println(err.code); }
    return 0;
}
