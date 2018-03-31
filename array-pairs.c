// https://www.hackerrank.com/challenges/array-pairs/problem
// score: 21.05 / 100

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

#define MAX_N 500000
uint64_t array[MAX_N];

int main() {
    int n;
    scanf("%d", &n);

    for (int i = 0; i < n; i++)
        scanf("%lu", &array[i]);

    int count = 0;
    for (int i = 0; i < n; i++) {
        uint64_t max = array[i];
        for (int j = i + 1; j < n; j++) {
            if (array[j] > max)
                max = array[j];
            if (array[i] * array[j] <= max)
                count++;
        }
    }

    printf("%d\n", count);

    return 0;
}
