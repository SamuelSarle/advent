g←¬⊏[w,l,r,u,d]←"#<>^v"=⌜>•Flines"input_24.txt"
e←⌽⌽˘s←1⌾(0‿1⊸⊑)(≢g)⥊0
MB←1⊸⌽⌾(1⊸⌽↑˜2-˜≠)
M←⌈˝⊢∾«˘∾»˘∾«≍»
BFS←{{u(MB)↩⋄d(MB⌾⌽)↩⋄l(MB⌾⍉)↩⋄r(MB⌾(⌽∘⍉))↩⋄(0⊸<+⊢)(¬w∨l∨r∨u∨d)×M𝕩}•_while_(0⊸=·⌈´·⥊𝕨×⊢)𝕩}
•Show 1-˜⌈´⥊ ss←e BFS s
•Show 1-˜⌈´⥊ e BFS s× s BFS e×ss
