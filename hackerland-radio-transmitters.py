# https://www.hackerrank.com/challenges/hackerland-radio-transmitters/problem
# score: 25 / 25 (medium)

def count_smaller(xs, start, value):
    for i in range(start, len(xs) + 1):
        if i >= len(xs) or xs[i] >= value:
            return i - start

def count_transmitters(xs, k):
    cnt = i = 0
    while i < len(xs):
        i += count_smaller(xs, i, xs[i] + k + 1) - 1
        i += count_smaller(xs, i, xs[i] + k + 1)
        cnt += 1
    return cnt

n, k = map(int, input().split())
xs = sorted(map(int, input().split()))
print(count_transmitters(xs, k))
