# https://www.hackerrank.com/challenges/no-prefix-set/problem
# score: 50 / 50

trie = {}

def clashes(s):
    node = trie
    for c in s:
        if 'terminal' in node:
            return True
        if c not in node:
            return False
        node = node[c]
    return True

def insert(s):
    node = trie
    for c in s:
        if c not in node:
            node[c] = {}
        node = node[c]
    node['terminal'] = True

for _ in range(int(input())):
    s = input().strip()
    if clashes(s):
        print("BAD SET")
        print(s)
        break
    insert(s)
else:
    print('GOOD SET')
