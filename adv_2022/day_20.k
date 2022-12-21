i:`I$0:"adv_2022/input_20.txt"

mix:{
  p::!#x
  y{{ol::p[x]
    nw::(-1+#p)!(ol+y)
    $[nw=0;nw::-1+#p;]
    ir:{(~y<x)&(~y>z)}
    p::(#p)!p+((nw<ol)*ir[nw;p;ol])-((ol<nw)*ir[ol;p;nw])
    p[x]::nw
  }'[(!#x);x];x}/x;
  r::(#x)#0;{r::@[r;x;:;i[y]]}'[p;!#p];r}

a:{+/x@(#x)!(*&0=x)+1e3*1+!3}

res:mix[i;1]
a res

i*:811589153
res:mix[i;10]
a res
