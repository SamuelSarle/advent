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
iid←¯1
i←AW¬»˘9‿4⥊1

cs←⋈0
hs←¯1+Highest¨{r←rs⊑˜(≠rs)|𝕩
 rid←𝕩
 m←(1⊑≢r)Expand i
 i↩m∨»˘m{iid↩(≠inst)|1+iid
         0⊸=◶⊢‿{𝕩⋄cs∾↩rid}iid
         «˘(𝕨Coll (iid⊑inst) P𝕩)◶⟨(iid⊑inst)⊸P,⊢⟩𝕩}•_while_{¬𝕩Coll˜RW𝕨} m Fit r
}¨↕3500

•Show 2021⊑hs # part 1
len←-´⟨last,prev⟩←2↑⌽cs
ch←-´last‿prev⊏hs
•Show (ch×⌊len÷˜1e12) + hs⊑˜¯1+len|1e12 # part 2
