Split←(⊢-˜¬×·+`»⊸<)∘∊˜⊔⊢
ToInt←10⊸×⊸+˜´∘⌽-⟜'0'
CreateMap←{c←⍷∾∾{{fx‿fy‿sx‿sy: dx‿dy←(sx-fx)‿(sy-fy)⋄<(fx‿fy⊸+)¨⥊((×dx)×↕1+|dx)⋈⌜((×dy)×↕1+|dy)}∘⥊˘2↕∘‿2⊸⥊}¨(ToInt¨", ->"⊸Split)¨𝕩⋄minx‿·←⌊´c⋄maxx‿maxy←⌈´c⋄⟨⍉(↕(1+maxx-minx)‿(1+maxy))∊(|minx‿0⊸-¨c), minx⟩}

⟨map,minx⟩←CreateMap •Flines"input_14.txt"
source←(500-minx)=((≢map)⥊↕≠⥊map)

Moves←(»∾«˘∘»≍»˘∘»)
Move←{(∧´∘⥊˘∘(1⊸≥)∘(𝕨⊸+˘)/⊢)Moves𝕩}
Drop←{𝕨⊸{(0⊸=≠)◶⊏‿𝕩 𝕨 Move𝕩}{𝔽∘⊢⍟≢⟜𝔽_𝕣∘⊢⍟≢⟜𝔽𝕩}𝕩}
Fill←{𝕨⊸{𝕩∨𝕩 Drop 𝕨}{𝔽∘⊢⍟≢⟜𝔽_𝕣∘⊢⍟≢⟜𝔽𝕩}𝕩}

•Show +´⥊map-˜source Fill map

Expand←{(¬«∘¬∘»)(2‿0⊸+∘≢↑⊢)⍉(-⌊(𝕨-≠⍉𝕩)÷2)⌽𝕨↑⍉𝕩}

•Show map {+´⥊({𝕩∨3=+˝Moves𝕩}⍟(≠𝕨)𝕨) -˜ ∨˝∘(⊢∾Moves)⍟(≠𝕨)𝕩}○((2×2+≠map)⊸Expand) source
