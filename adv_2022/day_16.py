import re
from functools import lru_cache

flows = {}
paths = {}
with open("input_16.txt") as f:
    rg = re.compile(r"Valve (\w\w) has flow rate=(\d+); tunnels? leads? to valves? ((?:\w\w,? ?)+)")
    for l in f.readlines():
        m = re.fullmatch(rg, l.strip())
        flows[m.group(1)] = int(m.group(2))
        paths[m.group(1)] = m.group(3).split(", ")

workingflows = len([True for f in flows if flows[f] > 0])

@lru_cache(maxsize=10000000)
def maximize(start="AA", mins=30, open=None, elephant=None):
    if open == None:
        open = ()
    mins -= 1
    released = sum([flows[o] for o in open])
    if mins <= 0:
        return released

    if len(open) == workingflows:
        return released+mins*released

    subs = []
    if start not in open and flows[start] != 0:
        # subtrees where we stay at the current valve and open it
        o = tuple(sorted(open+tuple([start])))
        subs.append((start, mins, o))

    # subtrees where we move to another valve
    for p in paths[start]:
        subs.append((p, mins, open))

    if elephant != None:
        subs = prune(mins, with_elephant(elephant, open, subs))

    if len(subs) > 0:
        return released+max(0, *[maximize(*s) for s in subs])
    else:
        return released

def prune(mins, subs):
    thresh = 0
    if mins < 20:
        thresh = 4
    elif mins < 15:
        thresh = 8
    elif mins < 10:
        thresh = 10
    return [s for s in subs if len(s[2]) >= thresh]

def with_elephant(elephant, open, subs):
    orig = len(subs)
    for i in range(0, len(subs)):
        # subtrees where elephant opens current valve
        if elephant not in open and flows[elephant] != 0:
            o = tuple(sorted(subs[i][2]+tuple([elephant])))
            n = (*subs[i][:2],o,elephant)
            subs.append(n)

        # subtrees where elephant moves to another valve
        for p in paths[elephant]:
            t = (*subs[i][:3], p)
            subs.append(t)

    return [(min(s[0],s[3]),s[1],s[2],max(s[0],s[3])) for s in subs[orig:] if s[0] != s[-1]]

print(maximize())
print(maximize(mins=26, elephant="AA"))
