// https://www.hackerrank.com/challenges/crush/problem
// progress: 100%

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int main() {
    long int n, m, a, b, k;
    scanf("%li %li", &n, &m);
    long int *array = calloc(n + 1, sizeof(long int));
    while (m--) {
        scanf("%li %li %li", &a, &b, &k);
        a--;
        array[a] += k;
        array[b] -= k;
    }
    long int v = 0, max = 0;
    for (int i = 0; i < n; i++) {
        v += array[i];
        if (v > max) max = v;
    }
    printf("%li\n", max);
    return 0;
}
