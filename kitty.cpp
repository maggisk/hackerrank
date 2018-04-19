// https://www.hackerrank.com/challenges/kittys-calculations-on-a-tree/problem
// score: 62.4 / 80
// gcc -std=c++14 -lstdc++ -O3 -Wall kitty.cpp

#include <iostream>
#include <map>
#include <set>
#include <vector>
#include <algorithm>
#include <cinttypes>
#include <cstring>
using namespace std;

#define N_MAX 200000

const uint64_t RESULT_MOD = 1e9 + 7;

int PARENT[N_MAX + 1];
vector<int> CHILDREN[N_MAX + 1];

vector<int> ACCUMULATOR_DEPTHS[N_MAX + 1];
vector<uint64_t> QUERY_ACCUMULATOR[N_MAX + 1];
vector<int> NON_EMPTY_CHILDREN[N_MAX + 1];

void merge(int node, int child) {
    for (int depth : ACCUMULATOR_DEPTHS[child]) {
        if (QUERY_ACCUMULATOR[node][depth + 1] == 0)
            ACCUMULATOR_DEPTHS[node].push_back(depth + 1);
        QUERY_ACCUMULATOR[node][depth + 1] += QUERY_ACCUMULATOR[child][depth];
        QUERY_ACCUMULATOR[child][depth] = 0;
    }
    ACCUMULATOR_DEPTHS[child].clear();
}

uint64_t query(int N) {
    uint64_t score = 0;

    for (int node = N; node >= 1; node--) {
        if (NON_EMPTY_CHILDREN[node].empty())
            continue;
        for (int child : NON_EMPTY_CHILDREN[node]) {
            for (int node_depth : ACCUMULATOR_DEPTHS[node])
                for (int child_depth : ACCUMULATOR_DEPTHS[child])
                    score = (score + QUERY_ACCUMULATOR[node][node_depth] * QUERY_ACCUMULATOR[child][child_depth] * (node_depth + child_depth + 1)) % RESULT_MOD;
            if (node > 1)
                merge(node, child);
            NON_EMPTY_CHILDREN[node].clear();
        }
        if (node > 1)
            NON_EMPTY_CHILDREN[PARENT[node]].push_back(node);
    }

    return score;
}

void construct_tree(int N) {
    int MAX_CHILD_DEPTH[N_MAX + 1] = {0};

    for (int i = 1; i < N; i++) {
        int a, b;
        scanf("%d %d", &a, &b);
        if (a > b)
            swap(a, b);
        CHILDREN[a].push_back(b);
        PARENT[b] = a;
    }

    for (int node = N; node >= 1; node--) {
        MAX_CHILD_DEPTH[PARENT[node]] = max(MAX_CHILD_DEPTH[PARENT[node]], MAX_CHILD_DEPTH[node] + 1);
        QUERY_ACCUMULATOR[node].resize(MAX_CHILD_DEPTH[node] + 1);
    }
}

int main() {
    int N, Q;
    scanf("%d %d", &N, &Q);

    construct_tree(N);

    while (Q--) {
        int K, node;
        scanf("%d", &K);
        while (K--) {
            scanf("%d", &node);
            QUERY_ACCUMULATOR[node][0] += node;
            ACCUMULATOR_DEPTHS[node].push_back(0);
            NON_EMPTY_CHILDREN[PARENT[node]].push_back(node);
        }

        printf("%llu\n", query(N));
    }
}
