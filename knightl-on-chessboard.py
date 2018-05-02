# https://www.hackerrank.com/challenges/knightl-on-chessboard/problem
# score: 35 / 35 (medimum)

from collections import deque

def count_moves(n, a, b):
    q = deque([(0, 0, 0)])
    seen = set([(0, 0)])
    while q:
        n_moves, x, y = q.popleft()
        if x == n - 1 and y == n - 1:
            return n_moves
        for x, y in [(x+a,y+b), (x+a,y-b), (x-a,y+b), (x-a,y-b), (x+b,y+a), (x+b,y-a), (x-b,y+a), (x-b,y-a)]:
            if 0 <= x < n and 0 <= y < n and (x, y) not in seen:
                seen.add((x, y))
                q.append((n_moves + 1, x, y))
    return -1

n = int(input())
for a in range(1, n):
    print(' '.join(str(count_moves(n, a, b)) for b in range(1, n)))
