// https://www.hackerrank.com/challenges/counter-game/problem
// progress: 100%

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

long int get_msb(long int a) {
    for (long int b = a & (a - 1); b; b &= b - 1)
        a = b;
    return a;
}

int bitcount(long int a) {
    int c = 0;
    for (; a; c++)
        a &= a - 1;
    return c;
}

char* counterGame(long int n) {
    int count = 0;
    while (n > 1) {
        count++;
        if (bitcount(n) > 1) {
            n -= get_msb(n);
        } else {
            n -= n / 2;
        }
    }
    return (count & 1) ? "Louise" : "Richard";
}

int main() {
    int t; 
    scanf("%i", &t);
    for(int a0 = 0; a0 < t; a0++){
        long int n; 
        scanf("%li", &n);
        char* result = counterGame(n);
        printf("%s\n", result);
    }
    return 0;
}
