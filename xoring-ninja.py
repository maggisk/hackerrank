# https://www.hackerrank.com/challenges/xoring-ninja/problem
# score: 23.57 of 55
from itertools import combinations
from functools import reduce
from operator import xor

for _ in range(int(input())):
    input()
    ns = [int(x) for x in input().split()]
    s = sum(reduce(xor, set_, 0) for i in range(1, len(ns) + 1) for set_ in combinations(ns, i))
    print(s % (10**9 + 7))
