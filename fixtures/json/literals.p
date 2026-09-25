function main() -> void {
    a := {"name": "Nick", "values": [1, 2], "active": true, "nothing": null};
    b := {"name": "Nick", "values": [1, 2], "active": true, "nothing": null};
    print(a == b);
    print(a["values"][1]);
    return;
}
