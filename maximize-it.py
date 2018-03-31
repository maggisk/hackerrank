# https://www.hackerrank.com/challenges/maximize-it/problem
# score: 50 of 50
from itertools import product
read_ints = lambda: list(map(int, input().split()))
K, M = read_ints()
L = [read_ints()[1:] for _ in range(K)]
print(max(sum(x**2 for x in xs) % M for xs in product(*L)))
