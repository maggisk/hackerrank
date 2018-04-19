# https://www.hackerrank.com/challenges/contacts/problem
# score 40 / 40

trie = {}

def add(s):
    node = trie
    for c in s:
        if c not in node:
            node[c] = {'count': 0}
        node = node[c]
        node['count'] += 1

def find(s):
    node = trie
    for c in s:
        if c not in node:
            return 0
        node = node[c]
    return node['count']

for _ in range(int(input())):
    action, s = input().strip().split(' ', 1)
    if action == 'add':
        add(s)
    elif action == 'find':
        print(find(s))
