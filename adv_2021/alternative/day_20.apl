bin ← {2⊥9⍴⍵}
expand ← {¯1⊖¯1⌽(2+⍴⍵)↑⍵}
stencil ← {⍺{('#'=⍵)∨(('#'=⍺)∧' '=⍵)}({⊂⍵}⌺3 3)⍵}
step ← {t←⍺[bin¨default stencil expand ⍵] ⋄ default∘←⍺[bin 9⍴'#'=default] ⋄ t}
solve1 ← {default∘←'.' ⋄ +/,'#'=⍺(step⍣2)⍵}
solve2 ← {default∘←'.' ⋄ +/,'#'=⍺(step⍣50)⍵}

input ← 100 100⍴⊃⎕NGET 'input.txt'
rules ← ⊃⎕NGET 'rules.txt'

rules solve1 input
rules solve2 input
