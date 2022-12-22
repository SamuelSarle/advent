import re

ds = [(1+0j), (0+1j), (-1+0j), (0-1j)]
m = {}
inst = []
with open("input_22.txt") as f:
    rawm, rawinst = f.read().split("\n\n")
    for y,l in enumerate(rawm.splitlines()):
        for x,c in enumerate(l):
            m[complex(x,y)] = c
    inst = re.findall(r"\d+|[LR]", rawinst)

def swrap(m,p,d):
    while m.get(p-d, ' ') != ' ': p -= d
    return p,d

def cwrap(m,p,d):
    di = ds.index(d)
    match (p.real//50,p.imag//50,di):
        case (1,0,2): di = 0; p = complex(0, 149-p.imag)
        case (1,0,3): di = 0; p = complex(0, 100+p.real)
        case (2,0,0): di = 2; p = complex(p.real-50, 149-p.imag)
        case (2,0,1): di = 2; p = complex(99,p.real-50)
        case (2,0,3): di = 3; p = complex(p.real-100,199)
        case (1,1,0): di = 3; p = complex(p.imag+50, 49)
        case (1,1,2): di = 1; p = complex(p.imag-50,100)
        case (0,2,2): di = 0; p = complex(50, 149-p.imag)
        case (0,2,3): di = 0; p = complex(50,p.real+50)
        case (1,2,0): di = 2; p = complex(149,149-p.imag)
        case (1,2,1): di = 2; p = complex(49,100+p.real)
        case (0,3,0): di = 3; p = complex(p.imag-100,149)
        case (0,3,1): di = 1; p = complex(p.real+100,0)
        case (0,3,2): di = 1; p = complex(p.imag-100,0)
    return p,ds[di]

def turn(d, i):
    if i == 'L': return complex(d.imag, -d.real)
    if i == 'R': return complex(-d.imag, d.real)

def walk(m, inst, p, d, wrap):
    for i in inst:
        if not i.isdigit():
            d = turn(d, i)
            continue
        for j in range(0, int(i)):
            n = p+d
            match m.get(n, ' '):
                case '#': break
                case '.': p = n
                case ' ':
                    np, nd = wrap(m,p,d)
                    if m[np] == '#': break
                    p, d = np, nd
    return p,d

def score(p,d):
    return int(1000*(1+p.imag)+4*(1+p.real)+ds.index(d))

d = complex(1,0)
p = complex(list(filter(lambda k: k.imag == 0 and m.get(k) == '.', m.keys()))[0],0)
print(score(*walk(m, inst, p, d, swrap)))
print(score(*walk(m, inst, p, d, cwrap)))
