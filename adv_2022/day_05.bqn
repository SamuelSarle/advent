Sp←(⊢-˜¬×·+`»⊸<)∘∊˜⊔⊢
ToInt←10⊸×⊸+˜´∘⌽-⟜'0'
ParseInit←{(0⊸<∘≠¨/⊢)⥊⋈∘{𝕩(∊/⊣)('A'+↕26)}˘⍉>𝕩}
ParseInst←{{ToInt¨1↓(" "∾'a'+↕26)Sp𝕩}¨𝕩}
_Move←{⟨st, n‿f‿t⟩←𝕩⋄f‿t↩1-˜f‿t⋄m←n↑f⊑st⋄(n↓f⊑st)⌾(f⊸⊑)((𝔽m)∾t⊑st)⌾(t⊸⊑)st}
P1←{⊑¨(ParseInit 8↑𝕩){⌽_Move⟨𝕩,>𝕨⟩}˝⌽(ParseInst 10↓𝕩)}
P2←{⊑¨(ParseInit 8↑𝕩){⊢_Move⟨𝕩,>𝕨⟩}˝⌽(ParseInst 10↓𝕩)}
input←•Flines "input_05.txt"
•Show P1 input
•Show P2 input
