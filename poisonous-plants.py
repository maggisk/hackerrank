# https://www.hackerrank.com/challenges/poisonous-plants/problem
# score 70 / 70

def take_smaller(vs, start):
    stack = []
    for i in range(start, len(vs)):
        if not stack or stack[-1] >= vs[i]:
            stack.append(vs[i])
        else:
            break
    stack.reverse()
    return stack

def split(vs):
    stacks = []
    index = 0
    while index < len(vs):
        stack = take_smaller(vs, index)
        index += len(stack)
        stacks.append(stack)
    return stacks

def join(stacks):
    r = [stacks[0]]
    for stack in stacks[1:]:
        if not stack or stack[-1] <= r[-1][0]:
            r[-1][:0] = stack
        else:
            r.append(stack)
    return r

def count_days(stacks):
    day = 0
    while len(stacks) > 1:
        for stack in stacks[1:]:
            stack.pop()
        stacks = join(stacks)
        day += 1
    return day

N = int(input())
stacks = split([int(x) for x in input().split()])
print(count_days(stacks))
