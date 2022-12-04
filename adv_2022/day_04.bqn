Sp←(⊢-˜¬×·+`»⊸<)∘∊˜⊔⊢
ToInt←10⊸×⊸+˜´∘⌽-⟜'0'
Parse←{ToInt¨>"-,"⊸Sp¨𝕩}
Encompass←{a‿b‿c‿d:((a≤c)∧(b≥d))∨((c≤a)∧(d≥b))}
Overlap←{a‿b‿c‿d:(b≥c)∧(a≤d)}
P1←{+´Encompass˘Parse𝕩}
P2←{+´Overlap˘Parse𝕩}
input←•Flines "input_04.txt"
•Show P1 input
•Show P2 input
