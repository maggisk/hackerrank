# https://www.hackerrank.com/challenges/queries-with-fixed-length/problem
# score: 50 / 50
_, Q = map(int, input().split())
values = list(map(int, input().split()))
for _ in range(Q):
    d = int(input())
    cmin = cmax = max(values[i] for i in range(d))
    for i in range(d, len(values)):
        if values[i - d] == cmax:
            cmax = max(values[i] for i in range(i - d + 1, i + 1))
        else:
            cmax = max(cmax, values[i])
        cmin = min(cmin, cmax)
    print(cmin)
