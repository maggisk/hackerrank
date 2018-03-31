// https://www.hackerrank.com/challenges/xor-key/problem
// score: 8.89 / 80

#include <assert.h>
#include <limits.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N_MAX 100000
int XS[N_MAX + 1];
int T, N, Q;

int main(void) {
    scanf("%d", &T);
    while (T--) {
        scanf("%d %d", &N, &Q);
        for (int i = 1; i <= N; i++)
            scanf("%d", &XS[i]);
        for (int i = 0; i < Q; i++) {
            int a, p, q;
            scanf("%d %d %d", &a, &p, &q);
            int max = XS[p++] ^ a;
            for (; p <= q; p++) {
                int v = XS[p] ^ a;
                if (v > max)
                    max = v;
            }
            printf("%d\n", max);
        }
    }
}
