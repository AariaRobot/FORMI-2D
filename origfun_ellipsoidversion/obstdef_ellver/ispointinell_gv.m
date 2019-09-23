function resvec=ispointinell_gv(M,K,point)
diffs = point-K;
diffst = reshape(diffs,1,2,[]);
diffs = reshape(diffs,2,1,[]);
p1 = pagefun(@mtimes,diffst,M);
p2 = pagefun(@mtimes,p1,diffs);
resvec=squeeze(p2<1);