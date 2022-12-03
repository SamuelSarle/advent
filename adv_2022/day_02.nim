import std/[sugar, strutils, sequtils, tables]

proc score(x: tuple[f: string, s: string]): int =
  result = 0
  var xs = initTable[string, int]()
  case x.s:
    of "X":
      result += 1
      xs = {"A": 3, "B": 0, "C": 6}.toTable
    of "Y":
      result += 2
      xs = {"A": 6, "B": 3, "C": 0}.toTable
    of "Z":
      result += 3
      xs = {"A": 0, "B": 6, "C": 3}.toTable
  result += xs[x.f]
  return

proc score2(x: tuple[f: string, s: string]): int =
  var xs = initTable[string, int]()
  case x.s:
    of "X":
      result += 0
      xs = {"A": 3, "B": 1, "C": 2}.toTable
    of "Y":
      result += 3
      xs = {"A": 1, "B": 2, "C": 3}.toTable
    of "Z":
      result += 6
      xs = {"A": 2, "B": 3, "C": 1}.toTable
  result += xs[x.f]
  return

proc splitPairs(x: string): tuple[f: string, s: string] =
  let a = x.split()
  return (f: a[0], s: a[1])

const input = readFile("adv_2022/input_02.txt")

let total = input
  .strip()
  .splitlines()
  .map((s) => s
       .splitPairs()
       .score())
  .foldl(a+b)

let total2 = input
  .strip()
  .splitlines()
  .map((s) => s
       .splitPairs()
       .score2())
  .foldl(a+b)

echo "First part: ", total
echo "Second part: ", total2
