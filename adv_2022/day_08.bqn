ToInt←10⊸×⊸+˜´∘⌽-⟜'0'
_Around_←{>𝔾˝⟨𝔽𝕩,𝔽⌾(⌽˘)𝕩,𝔽⌾⍉𝕩,𝔽⌾(⍉∘⌽)𝕩⟩}
P1←{+´⥊(∊∧≥⟜(⌈`))˘_Around_∨𝕩}
Dist←{{x‿xs:0⊸<∘≠◶⟨0,({(≠xs)=𝕩}◶⟨1⊸+,⊢⟩⊑0⊐˜x>xs)⟩xs}¨<∘⌽˘⍉({1↓↓𝕩}≍⊢)𝕩}
P2←{⌈´⥊Dist˘_Around_×𝕩}
input←ToInt∘≍¨>•Flines"input_08.txt"
•Show P1 input
•Show P2 input
