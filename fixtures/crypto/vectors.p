include <encoding>;
include <crypto>;

function main() -> int : (CryptoError, EncodingError) {
    bytes empty := bytes();
    bytes binary := [0, 255, 128];
    bytes expected_sha := [227, 176, 196, 66, 152, 252, 28, 20, 154, 251, 244, 200, 153, 111, 185, 36, 39, 174, 65, 228, 100, 155, 147, 76, 164, 149, 153, 27, 120, 82, 184, 85];
    bytes expected_hmac := [247, 188, 131, 244, 48, 83, 132, 36, 177, 50, 152, 230, 170, 111, 177, 67, 239, 77, 89, 161, 73, 70, 23, 89, 151, 71, 157, 188, 45, 26, 60, 216];
    bytes key := bytes.from_string("key");
    bytes message := bytes.from_string("The quick brown fox jumps over the lazy dog");
    print(base64_encode(bytes.from_string("foobar")));
    print(base64url_encode(binary));
    print(base64_decode("AP+A") == binary);
    print(base64url_decode("AP-A") == binary);
    print(constant_time_equal(sha256(empty), expected_sha));
    print(constant_time_equal(hmac_sha256(key, message), expected_hmac));
    print(secure_random_bytes(16).length());
    return 0;
}
