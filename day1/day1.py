# Advent of Code 2021: Day 1 🐍
def part1(list):
    last = -1
    results = []
    for i in range(len(list)):
        if i == 0:
            results.append("N/A - no previous measurement")
            last = list[i]
        else:
            if last < list[i]:
                results.append("increased")
            else:
                results.append("decreased")
            last = list[i]
    return results

def part2(list):
    last = -1
    results = []
    for i in range(len(list)):
        if i < (len(list) - 2):
            total = list[i] + list[i + 1] + list[i + 2]
            if i == 0:
                results.append("N/A - no previous measurement")
                last = total
            else:
                if last < total:
                    results.append("increased")
                elif last == total:
                    results.append("no change")
                else:
                    results.append("decreased")
                last = total
    return results

test_data, input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263], 
with open("input.txt") as f:
    for line in f:
        input.append(int(line.strip()))
    f.close()
print("Part 1 (Test Data): " + str(sum("increased" in s for s in part1(test_data))))
print("Part 2 (Test Data): " + str(sum("increased" in s for s in part2(test_data))))
print("Part 1 :" + str(sum("increased" in s for s in part1(input))))
print("Part 2 :" + str(sum("increased" in s for s in part2(input))))
