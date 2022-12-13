from functools import cmp_to_key
with open("input_13.txt") as f:
    ls = [eval(x) for x in f.read().split("\n") if x != ""]

sign = lambda x: (x>0)-(x<0)

def ordered(l, r):
    if type(l) == int and type(r) == int:
        return sign(r-l)
    elif type(l) == int:
        return ordered([l], r)
    elif type(r) == int:
        return ordered(l, [r])
    for i in range(0, min(len(l), len(r))):
        o = ordered(l[i], r[i])
        if o != 0:
            return o
    return sign(len(r)-len(l))

ps = [ls[i:i+2] for i in range(0, len(ls), 2)]
print(sum([i+1 for i in range(0,len(ps)) if ordered(ps[i][0],ps[i][1]) == 1]))

extra = [[[2]],[[6]]]
ls += extra
ls = sorted(ls, key=cmp_to_key(ordered), reverse=True)
print((1+ls.index(extra[0]))*(1+ls.index(extra[1])))
