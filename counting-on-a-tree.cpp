// https://www.hackerrank.com/challenges/counting-on-a-tree/problem
// score: 100 / 100

#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include <map>
#include <string.h>

#define N_MAX 100000

int WEIGHTS[N_MAX + 1];
int PARENT[N_MAX + 1];

int COUNTS[N_MAX + 1];
bool SET[N_MAX + 1];

void normalize_weights(int N) {
    std::map<int,int> normalized;
    for (int i = 1; i <= N; i++) {
        if (normalized.count(WEIGHTS[i]) == 0)
            normalized[WEIGHTS[i]] = normalized.size();
        WEIGHTS[i] = normalized[WEIGHTS[i]];
    }
}

int prep_node(int node) {
    SET[node] = true;
    COUNTS[WEIGHTS[node]]++;
    return PARENT[node];
}

void prep_w_x(int w, int x) {
    while (w != x) {
        if (w > x)
            w = prep_node(w);
        else
            x = prep_node(x);
    }
    prep_node(w);
}

int count_node(int node, int *count) {
    *count += COUNTS[WEIGHTS[node]];
    if (SET[node])
        (*count)--;
    return PARENT[node];
}

int count_y_z(int y, int z) {
    int count = 0;
    while (y != z) {
        if (y > z)
            y = count_node(y, &count);
        else
            z = count_node(z, &count);
    }
    count_node(y, &count);
    return count;
}

int main(void) {
    int N, Q;
    scanf("%d %d", &N, &Q);

    for (int i = 1; i <= N; i++)
        scanf("%d", &WEIGHTS[i]);
    normalize_weights(N);

    for (int i = 1; i < N; i++) {
        int a, b;
        scanf("%d %d", &a, &b);
        if (a > b)
            std::swap(a, b);
        PARENT[b] = a;
    }

    while (Q--) {
        int w, x, y, z;
        scanf("%d %d %d %d", &w, &x, &y, &z);
        prep_w_x(w, x);
        int count = count_y_z(y, z);
        printf("%d\n", count);

        memset(&SET, 0, (N+1) * sizeof(SET[0]));
        memset(&COUNTS, 0, (N+1) * sizeof(COUNTS[0]));
    }

    return 0;
}
