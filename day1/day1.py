# Part 1
input = []
with open("day1_input.txt") as f:
    for line in f:
        stripped = line.strip()
        input.append(int(stripped))
    f.close()

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

def count(list):
    data = list
    count = 0
    for i in range(len(list)):
        if list[i] == "increased":
            count += 1
    return count

print(str(count(part1(input))))

# Part 2
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

# testData = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

print(str(count(part2(input))))

