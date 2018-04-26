# https://www.hackerrank.com/challenges/minimum-average-waiting-time/problem
# score 80 / 80

from heapq import heappush, heappop
from collections import namedtuple

Order = namedtuple('Order', ['duration', 'placed_at'])

def process_orders(orders):
    q = [orders.pop()]
    current_time = q[0].placed_at

    while orders or q:
        while orders and orders[-1].placed_at <= current_time:
            heappush(q, orders.pop())
        if q:
            order = heappop(q)
            current_time += order.duration
            yield current_time - order.placed_at
        else:
            heappush(q, orders.pop())
            current_time = q[0].placed_at

N = int(input())
orders = [Order(*map(int, input().split()[::-1])) for _ in range(N)]
orders.sort(key=lambda o: -o.placed_at)
print(sum(process_orders(orders)) // N)
