function main() -> void {
    int* p := ptr(7);
    int** pp := ptr(p);
    int*** ppp := ptr(pp);
    print(***ppp);
    **pp = 9;
    print(*p);
    int*& rp := ref(p);
    **pp = **pp + 1;
    print(**pp);
    print(**rp);
    return;
}
