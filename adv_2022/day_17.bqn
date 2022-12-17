h←⍉≍1‿2‿3‿4∊˜↕7
c←7‿9‿10‿11‿13∊˜7‿3⥊↕21
l←6‿7‿8‿11‿14∊˜7‿3⥊↕21
v←»⍟4 7‿4↑4⥊1
b←»⍟3 7‿2↑2‿2⥊1
rs←»¨9⊸↑¨(⌽⌽˘)¨⟨h,c,l,v,b⟩

Coll←(∨´∘⥊∘∧)
RW←»∘«∘«∘»
AW←RW⌾¬
P←{𝕨⊸⊣◶⟨«,»⟩𝕩}
Highest←{⌈´+´˘∨`∘⌽˘RW𝕩}
Expand←{AW(𝕨⊸+∘3⊸+∘Highest↑˘⊢)RW 𝕩}
Fit←(1⊸⊑∘≢)⊸(↑˘)⌾(⌽˘)

inst←"<>"⊐¯1↓•FChars "input_17.txt"
idx←¯1
i←AW¬»˘9‿5⥊1

{i{m←(1⊑≢𝕩)Expand𝕨 ⋄ i↩m∨»˘m{idx↩(≠inst)|1+idx⋄«˘(𝕨Coll (idx⊑inst) P𝕩)◶⟨(idx⊑inst)⊸P,⊢⟩𝕩}•_while_{¬𝕩Coll˜RW𝕨} m Fit 𝕩} rs⊑˜(≢rs)|𝕩}¨↕2022
•Show ¯1+Highest i
