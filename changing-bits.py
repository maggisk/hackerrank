def set_bit(v, index, on):
    bit = 1 << index
    return v | bit if on else v & ~bit

n, q = map(int, input().split())

a = int(input(), 2)
b = int(input(), 2)

for _ in range(q):
    k, *args = input().split()
    args = list(map(int, args))
    if k == 'set_a':
        a = set_bit(a, *args)
    elif k == 'set_b':
        b = set_bit(b, *args)
    elif k == 'get_c':
        print(((a + b) >> args[0]) & 1, end='')

print('')
