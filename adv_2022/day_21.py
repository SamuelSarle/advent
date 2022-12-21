m = {}
with open('input_21.txt') as f:
    ls = f.read().splitlines()
    for l in ls:
        k, v = l.split(": ")
        if v.isdigit():
            m[k] = int(v)
            continue
        vs = v.split()
        m[k] = vs

def op(m1, o, m2):
    if o == '+': return m1 + m2
    if o == '-': return m1 - m2
    if o == '*': return m1 * m2
    if o == '/': return m1 // m2
    if o == '=': return m2 - m1

def yell(m, n):
    if type(m[n]) == int:
        return m[n]
    l,o,r = m[n]
    v = op(yell(m, l), o, yell(m, r))
    return v

print(yell(m, 'root'))

m['root'][1] = '='
i = 0
while True:
    m['humn'] = i
    d = yell(m,'root')
    if d == 0:
        print(i)
        break
    # magic number, why do some numbers converge but others don't?
    # working examples: 22, 23, 24, 28, 30, 100
    # numbers that finish with wrong answer (off-by-one): 25, 26, 29
    # numbers that don't finish: 20, 21, 27
    i -= d // 100
