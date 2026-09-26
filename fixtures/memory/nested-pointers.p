function main() -> void {
    int* p := new(7);
    int** pp := new(p);
    int*** ppp := new(pp);
    print(***ppp);
    **pp = 9;
    print(*p);
    int*& rp := ref(p);
    **pp = **pp + 1;
    print(**pp);
    print(**rp);
    return;
}
