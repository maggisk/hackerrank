# https://www.hackerrank.com/challenges/2s-complement/problem
# score: 70 / 70

def count(n):
    if n < 0:
        return 32 * (-n) - count(-n - 1)

    cnt = mul = 0
    for i in range(31, -1, -1):
        b = 1 << i
        if b & n:
            cnt += 1 + b * i // 2 + b * mul
            mul += 1
    return cnt

for _ in range(int(input())):
    a, b = map(int, input().split())
    if b < 0:
        print(count(a) - count(b + 1))
    elif a > 0:
        print(count(b) - count(a - 1))
    else:
        print(count(a) + count(b))
