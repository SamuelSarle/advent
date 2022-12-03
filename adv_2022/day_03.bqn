alph←"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
P1←{+´1+alph⊐∾(2÷˜≢)⊸((↑∊○⍷↓)/⍷∘↑)¨𝕩}
P2←{+´1+alph⊐(⊑2⊐˜⊒)⊸⊑∘(∾⍷¨)˘↑‿3⥊𝕩}
input←•FLines "input_03.txt"
•Show P1 input
•Show P2 input
