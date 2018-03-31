// https://www.hackerrank.com/challenges/kittys-calculations-on-a-tree/problem
// score: 31%

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>

#define N_MAX 200000

uint32_t SET[100000 + 1];
uint32_t SET_SIZE;
bool SET_MAP[N_MAX + 1];

uint32_t PARENT[N_MAX + 1];

void map_insert(uint32_t a, uint32_t b) {
    if (a > b) return map_insert(b, a);
    assert(PARENT[b] == 0);
    PARENT[b] = a;
}

int *CHILDREN[N_MAX + 1];
int POOL[N_MAX * 2];

void generate_tree(int max_node) {
    int n_children[N_MAX + 1] = {0};
    for (int node = 2; node <= max_node; node++)
        n_children[PARENT[node]]++;

    int *pool = &POOL[0];
    for (int node = 1; node <= max_node; node++) {
        pool += n_children[node] + 1;
        CHILDREN[node] = pool;
    }

    for (int node = max_node; node >= 2; node--)
        *(--CHILDREN[PARENT[node]]) = node;
}

struct Match {
    int node, node_depth, lca, lca_depth;
};
struct Match M[N_MAX];
int N_M;
uint64_t SUM;

bool search(int node, int node_depth, int lca, int lca_depth) {
    if (SET_MAP[node]) {
        int lca_match_depth = lca_depth;
        for (int i = N_M - 1; i >= 0; i--) {
            struct Match *m = &M[i];
            SUM += (uint64_t)node * (uint64_t)m->node * (uint64_t)(node_depth + m->node_depth - 2 * lca_match_depth);
            if (m->lca_depth < lca_match_depth)
                lca_match_depth = m->lca_depth;
        }

        M[N_M++] = (struct Match){ node, node_depth, lca, lca_depth };
        lca = node;
        lca_depth = node_depth;
    }

    bool is_new_lca = SET_MAP[node];
    for (int *child = &CHILDREN[node][0]; *child; child++) {
        if (search(*child, node_depth + 1, lca, lca_depth)) {
            is_new_lca = true;
            lca = node;
            lca_depth = node_depth;
        }
    }

    return is_new_lca;
}

int main() {
    int n, q, a, b, c;
    scanf("%d %d", &n, &q);

    for (int i = 1; i < n; i++) {
        scanf("%d %d", &a, &b);
        map_insert(a, b);
    }

    generate_tree(n);

    while (q--) {
        scanf("%d", &SET_SIZE);

        for (int j = 0; j < SET_SIZE; j++) {
            scanf("%d", &SET[j]);
            SET_MAP[SET[j]] = true;
        }

        SUM = N_M = 0;
        search(1, 0, 0, 0);
        printf("%llu\n", SUM % 1000000007ULL);

        for (int j = 0; j < SET_SIZE; j++)
            SET_MAP[SET[j]] = false;

    }

    return 0;
}
