error ModuleError { string message; int code; }
function module_fail() -> int : ModuleError {
    throw ModuleError { message: "module", code: 9 };
}
