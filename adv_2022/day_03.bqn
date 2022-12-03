alph←" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
P1←{+´alph⊐∾(2÷˜≢)⊸(↓(∊/⊣)○⍷↑)¨𝕩}
P2←{+´alph⊐(⊑2⊐˜⊒)⊸⊑∘(∾⍷¨)˘↑‿3⥊𝕩}
input←•FLines "input_03.txt"
•Show P1 input
•Show P2 input
