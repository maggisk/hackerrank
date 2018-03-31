// https://www.hackerrank.com/challenges/xor-se/problem
// progress: 50%

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int main(){
    int Q; 
    scanf("%d",&Q);
    while (Q--) {
        long L, R; 
        scanf("%ld %ld", &L, &R);

        long i = 0, sum = 0, x = 0;
        for (; i < L; i++) {
            x ^= i;
        }
        for (; i <= R; i++) {
            x ^= i;
            sum ^= x;
        }
        printf("%lu\n", sum);
    }
    return 0;
}

