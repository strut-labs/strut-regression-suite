include <vector>;
include <map>;
include <set>;
include <ordered_map>;
include <ordered_set>;
include <queue>;
include <stack>;
include <priority_queue>;
include <deque>;
include <list>;
function main() -> void {
    vector<int> v := [1,2,3];
    map<int,int> m := [1:10,2:20];
    set<int> s := [1,2,3];
    ordered_map<int,int> om;
    ordered_set<int> os;
    queue<int> q; stack<int> st; priority_queue<int> pq; priority_queue<int,min> minpq; deque<int> dq; list<int> li;
    om.insert(2,20); os.add(2); q.push(7); st.push(8); pq.push(9); minpq.push(9); minpq.push(2); dq.push(10); dq.push_front(11); li.push(12); li.push_front(13);
    print(v.length);
    print(m[2]);
    print(s.contains(3));
    print(q.front());
    print(st.top());
    print(pq.top());
    print(minpq.top());
    print(dq.front());
    print(li.back());
    return;
}
