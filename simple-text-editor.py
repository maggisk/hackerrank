# https://www.hackerrank.com/challenges/simple-text-editor/forum
# score: 65 / 65

stack = ['']

for _ in range(int(input())):
    do, *params = input().split()
    if do == "1":
        stack.append(stack[-1] + params[0])
    elif do == "2":
        stack.append(stack[-1][:-int(params[0])])
    elif do == "3":
        print(stack[-1][int(params[0]) - 1])
    elif do == "4":
        stack.pop()
