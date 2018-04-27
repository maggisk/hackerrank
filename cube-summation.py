# https://www.hackerrank.com/challenges/cube-summation/problem
# score: 50 / 50

for _ in range(int(input())):
    N, M = map(int, input().split())
    cube = {}
    for _ in range(M):
        action, *args = input().split()
        args = list(map(int, args))
        if action == 'UPDATE':
            x, y, z, W = args
            cube[(x, y, z)] = W
        else:
            x1, y1, z1, x2, y2, z2 = args
            print(sum(v for (x,y,z), v in cube.items() if x1 <= x <= x2 and y1 <= y <= y2 and z1 <= z <= z2))
