# https://www.hackerrank.com/challenges/truck-tour/problem
# score: 50 / 50
fuel = start_at = 0
for i in range(int(input())):
    available_fuel, distance_to_next_station = map(int, input().split())
    fuel += available_fuel - distance_to_next_station
    if fuel < 0:
        fuel = 0
        start_at = i + 1
print(start_at)
