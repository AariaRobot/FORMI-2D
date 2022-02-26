function resvec=ispointinell_vecver(M,K,point)
% point=flip(point);
diffs = point-K;
diffst = reshape(diffs,1,2,[]);
diffs = reshape(diffs,2,1,[]);
p2=zeros(1,size(diffs,3));
for ii=1:size(diffs,3)
    p2(ii)=diffst(:,:,ii)*M(:,:,ii)*diffs(:,:,ii);
end
% p1 = pagefun(@mtimes,diffst,M);
% p2 = pagefun(@mtimes,p1,diffs);
% resvec=squeeze(p2<1);
resvec = p2<1;