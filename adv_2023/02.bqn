Split←(⊢-˜¬×+`)∘∊˜⊔⊢
Int←10⊸×⊸+˜´∘⌽-⟜'0'
[gs,ds]←⍉>":"⊸Split¨ •Flines"02.txt"
draws←(Int¨⌾⊏˘↑‿2⥊·(⊢/˜0≠≠¨)" ,;"⊸Split)¨ds
maxes←>(⌈´¨1⊸⊏˘"red"‿"green"‿"blue"⊸⊐⊸⊔⊑˘)¨draws
•Show +´Int¨5↓¨maxes(∧´12‿13‿14⊸≥)˘⊸/gs
•Show +´×´˘ maxes
