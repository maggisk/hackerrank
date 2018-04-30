#https://www.hackerrank.com/challenges/maximum-subarray-sum/problem
# score 65 / 65 (hard)
from bisect import bisect_right

for _ in range(int(input())):
    n, m = map(int, input().split())
    sum_here = max_sum = 0
    sorted_sums = [m]
    for v in map(int, input().split()):
        sum_here = (sum_here + v) % m
        i = bisect_right(sorted_sums, sum_here)
        max_sum = max(max_sum, (m + sum_here - sorted_sums[i]) % m)
        if i == 0 or sorted_sums[i - 1] != sum_here:
            sorted_sums.insert(i, sum_here)
    print(max_sum)
