# https://www.hackerrank.com/challenges/median/problem
# score: 70 / 70

from heapq import heappush, heappop

def increment(d, k, diff):
    d[k] = d.get(k, 0) + diff
    assert d[k] >= 0
    if d[k] == 0:
        del d[k]

class Heap:
    def __init__(self, modifier = 1):
        self.q = []
        self.modifier = modifier
        self.is_in_q = {}
        self.lazy_delete = {}
        self.size = 0

    def push(self, v):
        v *= self.modifier
        increment(self.is_in_q, v, 1)
        heappush(self.q, v)
        self.size += 1

    def pop(self):
        self._compact()
        v = heappop(self.q)
        increment(self.is_in_q, v, -1)
        self.size -= 1
        return v * self.modifier

    def peek(self):
        self._compact()
        return self.q[0] * self.modifier

    def __contains__(self, v):
        return (v * self.modifier) in self.is_in_q

    def __len__(self):
        return self.size

    def remove(self, v):
        v *= self.modifier
        assert v in self.is_in_q
        increment(self.is_in_q, v, -1)
        increment(self.lazy_delete, v, 1)
        self.size -= 1

    def _compact(self):
        while self.q and self.q[0] in self.lazy_delete:
            increment(self.lazy_delete, self.q[0], -1)
            heappop(self.q)

smaller = Heap(-1)
larger = Heap()

def get_median():
    if len(smaller) or len(larger):
        if len(larger) > len(smaller):
            return larger.peek()
        if len(smaller) > len(larger):
            return smaller.peek()
        return (smaller.peek() + larger.peek()) / 2

def balance():
    if len(smaller) + 2 == len(larger):
        smaller.push(larger.pop())
    elif len(larger) + 2 == len(smaller):
        larger.push(smaller.pop())

def append(v):
    median = get_median()
    if median is None or v < median:
        smaller.push(v)
    else:
        larger.push(v)
    balance()

def remove(v):
    if v in smaller:
        smaller.remove(v)
    elif v in larger:
        larger.remove(v)
    else:
        return False
    balance()

for _ in range(int(input())):
    action, v = input().split()
    if action == 'a':
        append(int(v))
        success = True
    else:
        success = remove(int(v))
    median = get_median()
    if not success or median is None:
        print('Wrong!')
    else:
        print(('%f' % median).rstrip('0').rstrip('.'))
