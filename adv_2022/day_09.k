abs:{x|-x}
sign:{$[x>0;1;x<0;-1;0]}'
m:{y+{$[3=+/abs x;sign x;(-1 -1+abs x)*(sign x)]}x-y}
d:"RLUD"!(1 0;-1 0;0 1;0 -1)
s:{(`I$2_x){
  p::h+:x
  ts::{:p::m[p;x]}'ts
  ls::ls,(-1#ts)
  x}/d[*x]}'

i:0:"input_09.txt"
h:0 0;ts:,0 0;ls:,0 0;
s i;#?ls / part 1

h:0 0;ts:9#,0 0;ls:,0 0;
s i;#?ls / part 2
