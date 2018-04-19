// https://www.hackerrank.com/challenges/poisonous-plants/problem
// score: 65 / 70

#include <stdio.h>

int vs[500001];

int days(int size) {
    int n_days = 0;
    while (1) {
        int at = 1;
        for (int i = 1; i < size; i++)
            if (vs[i] <= vs[i - 1])
                vs[at++] = vs[i];
        if (at == size)
            break;
        size = at;
        n_days++;
    }
    return n_days;
}

int main() {
    int N;
    scanf("%d", &N);
    for (int i = 0; i < N; i++)
        scanf("%d", &vs[i]);
    printf("%d\n", days(N));
    return 0;
}
