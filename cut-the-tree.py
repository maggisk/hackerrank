# https://www.hackerrank.com/challenges/cut-the-tree/problem
# score: 50 / 50 (medium)

from collections import defaultdict

n = int(input())
values = [0] + list(map(int, input().split()))
values_sum = sum(values)

edges = defaultdict(list)
for _ in range(n - 1):
    a, b = map(int, input().split())
    edges[a].append(b)
    edges[b].append(a)

parent_of = {}
depth_of = {}
visited = set()
stack = [(1, 0, 0)]
while stack:
    node, parent, depth = stack.pop()
    if node not in visited:
        visited.add(node)
        parent_of[node] = parent
        depth_of[node] = depth
        for child in edges[node]:
            stack.append((child, node, depth + 1))

min_diff = float('inf')
child_tree_sum = defaultdict(int)
for node in sorted(range(1, n + 1), key=lambda node: depth_of[node], reverse=True):
    subtree_sum = values[node] + child_tree_sum[node]
    min_diff = min(min_diff, abs(values_sum - subtree_sum * 2))
    child_tree_sum[parent_of[node]] += subtree_sum

print(min_diff)
