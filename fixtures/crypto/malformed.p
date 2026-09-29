include <encoding>;

function rejects(string value, bool url) -> bool {
    try {
        if (url) { base64url_decode(value); }
        else { base64_decode(value); }
    } catch (EncodingError caught) {
        return true;
    }
    return false;
}

function main() -> int {
    print(rejects("AB==", false));
    print(rejects("AAB=", false));
    print(rejects("AA A", false));
    print(rejects("AB", true));
    print(rejects("AA=", true));
    print(rejects("AA+A", true));
    return 0;
}
