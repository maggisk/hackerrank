# https://www.hackerrank.com/challenges/2s-complement/problem
# score: 70 / 70

def count_positive(n):
    count = mul = 0
    for i in range(31, -1, -1):
        b = 1 << i
        if b & n:
            count += 1 + b * i // 2 + b * mul
            mul += 1
    return count

def count_negative(n):
    n = -n
    return 32 * n - count_positive(n - 1)

def count(n):
    return count_positive(n) if n >= 0 else count_negative(n)

for _ in range(int(input())):
    a, b = map(int, input().split())
    if b < 0:
        print(count(a) - count(b + 1))
    elif a > 0:
        print(count(b) - count(a - 1))
    else:
        print(count(a) + count(b))
