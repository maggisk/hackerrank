# https://www.hackerrank.com/challenges/minimum-loss/problem
# score: 35 / 35 (medium)
from bisect import insort, bisect_left

s, m, n = [-float('inf')], float('inf'), int(input())
for v in reversed(list(map(int, input().split()))):
    m = min(m, v - s[bisect_left(s, v) - 1])
    insort(s, v)
print(m)
