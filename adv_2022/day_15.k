i:0:"input_15.txt"
p:{2 2#`I$'(,/":"\',/","\'"="\x)@1 3 5 7}'
abs:{x|-x}
man:{+/abs x-y}
(ss;bs):+{x@<*''x}p i
ds:ss{man[x;y]}'bs

row:_2e6
r:{x@&{2=#x}'x}ss{d:abs row-*1_x;$[~y<d;{(y-x;y+x)}[y-d;(*x)];,]}'ds
(*1_|/r)-(*&/r) / part 1

ans:0
lim:_4e6
{(x<lim)&0~ans}{i::0;ds{
  w:y-abs x-*1_z;b:-1+(*z)-w
  $[~w>0;
    0<b-i; $[&/ds<ss man\:(b;x);ans::(b;x);]
    i|:lim&(*z)+w]
  }[x;]'ss; x+1}/0;
(ans@1)+lim*ans@0 / part 2
