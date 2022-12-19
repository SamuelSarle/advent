from collections import namedtuple
from dataclasses import dataclass
from math import ceil

Bp = namedtuple("Blueprint", "ore_r_ore clay_r_ore obs_r_ore obs_r_clay g_r_ore g_r_obs")
bps = []
with open("input_19.txt") as f:
    for l in f.read().splitlines():
        bps.append(Bp(*[int(s) for s in l.split(" ") if s.isdigit()]))

@dataclass(eq=False)
class Resources:
    time: int = 24
    ore_r: int = 1
    clay_r: int = 0
    obs_r: int = 0
    g_r: int = 0
    ore: int = 0
    clay: int = 0
    obs: int = 0
    g: int = 0

def needed_time(r1, p1, r2=0, p2=0):
    if r2 != 0 and p2 != 0:
        return max(ceil(r1/p1), ceil(r2/p2))
    return ceil(r1/p1)

def ff(amount, res):
    return Resources(
        res.time-amount,
        res.ore_r,
        res.clay_r,
        res.obs_r,
        res.g_r,
        res.ore+(res.ore_r*amount),
        res.clay+(res.clay_r*amount),
        res.obs+(res.obs_r*amount),
        res.g+(res.g_r*amount))

def score(res):
    return max(0, res.g+(res.time * res.g_r))

def dfs(bp, res):
    best = 0
    q = [res]
    max_costs = [max([bp.ore_r_ore,bp.clay_r_ore,bp.obs_r_ore,bp.g_r_ore]),bp.obs_r_clay,bp.g_r_obs]
    while q:
        r = q.pop()

        if r.time <= 0:
            best = max(best, score(r))
            continue

        if r.obs_r > 0:
            t = needed_time(max(0,bp.g_r_ore-r.ore), r.ore_r, max(0,bp.g_r_obs-r.obs), r.obs_r)
            fs = ff(t+1, r)
            fs.g_r += 1
            fs.ore -= bp.g_r_ore
            fs.obs -= bp.g_r_obs
            q.append(fs)
            if t == 0:
                continue

        if r.clay_r > 0 and r.obs_r < max_costs[2]:
            t = needed_time(max(0,bp.obs_r_ore-r.ore), r.ore_r, max(0,bp.obs_r_clay-r.clay), r.clay_r)
            fs = ff(t+1, r)
            fs.obs_r += 1
            fs.ore -= bp.obs_r_ore
            fs.clay -= bp.obs_r_clay
            q.append(fs)
            if t == 0:
                continue

        if r.ore_r <= max_costs[0]:
            t = needed_time(max(0,bp.ore_r_ore-r.ore), r.ore_r)
            fs = ff(t+1, r)
            fs.ore_r += 1
            fs.ore -= bp.ore_r_ore
            q.append(fs)

        if r.clay_r <= max_costs[1]:
            t = needed_time(max(0, bp.clay_r_ore-r.ore), r.ore_r)
            fs = ff(t+1, r)
            fs.clay_r += 1
            fs.ore -= bp.clay_r_ore
            q.append(fs)

    return best

p1 = 0
for i, bp in enumerate(bps):
    m = dfs(bp, Resources())
    p1 += m*(i+1)

p2 = 1
for bp in bps[:3]:
    m = dfs(bp, Resources(32))
    p2 *= m

print(p1)
print(p2)
