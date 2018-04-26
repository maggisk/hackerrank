# https://www.hackerrank.com/challenges/find-the-running-median/problem
# score 50 / 50

from heapq import heappush, heappop

smaller, larger = [], []

def append(v, median):
    if median is None or v < median:
        heappush(smaller, -v)
    else:
        heappush(larger, v)

    if len(smaller) + 2 == len(larger):
        heappush(smaller, -heappop(larger))
    elif len(larger) + 2 == len(smaller):
        heappush(larger, -heappop(smaller))

    if len(larger) > len(smaller):
        return larger[0]
    if len(smaller) > len(larger):
        return -smaller[0]
    return (-smaller[0] + larger[0]) / 2

median = None
for _ in range(int(input())):
    median = append(int(input()), median)
    print("%0.1f" % median)
