Split←(⊢-˜¬×·+`»⊸<)∘∊˜⊔⊢
ToInt←10⊸×⊸+˜´∘⌽-⟜'0'
N←(«⎉1∾»⎉1∾«˘∾»˘∾«≍»)
Sides←+´∘(0⊸</⊢)∘⥊∘(6⊸×-+˝∘N)
cube←(↕∘(1⊸+)∘(⌈´)∊⊢){ToInt¨","Split𝕩}¨•Flines "input_18.txt"
•Show Sides cube
outside←{V←(∨`∧∨`⌾⌽)⋄{(¬cube)∧𝕩∨∨˝N𝕩}{𝔽∘⊢⍟≢⟜𝔽_𝕣∘⊢⍟≢⟜𝔽𝕩}¬(V𝕩)∧(V⎉1𝕩)∧(V⎉2𝕩)}cube
•Show Sides ¬outside
