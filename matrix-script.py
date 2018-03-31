# https://www.hackerrank.com/challenges/matrix-script/problem
# score: 100 of 100
import re
n_rows, n_cols = [int(x) for x in input().split()]
rows = [input() for _ in range(n_rows)]
s = ''.join(rows[y][x] for x in range(n_cols) for y in range(n_rows))
s = re.sub(r'(\w)[\W ]+(\w)', r'\1 \2', s, flags=re.ASCII)
print(s)
