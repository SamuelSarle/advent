import heapq

def elf_totals(elves):
    totals = []
    for elf in elves:
        counts = elf.split("\n")
        sum = 0
        for c in counts:
            if c == "":
                continue
            sum += int(c)
        totals.append(sum)
    return totals

input = ""
with open("input_01.txt") as f:
    input = f.read()

elves = input.split("\n\n")
totals = elf_totals(elves)
print("First part: ", max(totals))
print("Second part: ", sum(heapq.nlargest(3, totals)))
