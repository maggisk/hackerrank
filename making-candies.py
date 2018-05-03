# https://www.hackerrank.com/challenges/making-candies/problem
# score: 45 / 45 (hard)
from math import ceil

def balance(spending, a, b):
    buy = min(spending, max(0, b - a))
    return spending - buy, a + buy

m, w, p, n = map(int, input().split())
turn = bank = 0
best = float('inf')
while True:
    best = min(best, turn + ceil((n - bank) / (m * w)))
    spending = bank // p
    spending, m = balance(spending, m, w)
    spending, w = balance(spending, w, m)
    m += spending // 2
    w += spending // 2 + (spending % 2)
    bank %= p
    if turn >= best:
        break
    turnskip = ceil((p - bank) / (m * w))
    bank += m * w * turnskip
    turn += turnskip
print(best)
