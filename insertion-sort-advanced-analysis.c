// https://www.hackerrank.com/challenges/insertion-sort/problem
// score: 50 of 50

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>

#define MAX_VALUE (10*1000*1000)
int bit_tree[MAX_VALUE + 1];

void bit_tree_insert(int i, int v) {
    while (i < MAX_VALUE) {
        bit_tree[i] += v;
        i += i & (-i);
    }
}

int bit_tree_lookup(int i) {
    int sum = 0;
    while (i > 0) {
        sum += bit_tree[i];
        i -= i & (-i);
    }
    return sum;
}

int bit_tree_range(int start, int end) {
    return bit_tree_lookup(end) - bit_tree_lookup(start - 1);
}

int main(void) {
    int T, N;
    scanf("%d", &T);
    while (T--) {
        scanf("%d", &N);
        int v, max = 0;
        long int s = 0;
        while (N--) {
            scanf("%d", &v);
            if (v > max) max = v;
            s += bit_tree_range(v + 1, max);
            bit_tree_insert(v, 1);
        }
        printf("%ld\n", s);
        memset(&bit_tree, 0, sizeof(bit_tree));
    }

    return 0;
}
