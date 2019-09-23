function [K,M]=findellipseparams_ng(obst,xws,yws,angs)
K=obst;
% D=diag([1/currxw,1/curryw]);
onum=length(xws);
D=(zeros(2,2,onum));
D(1,1,:)=1./xws;
D(2,2,:)=1./yws;
v0=(zeros(2,1,onum));
v0(1,1,:)=cos(angs);v0(2,1,:)=sin(angs);
v1=(zeros(2,1,onum));
v1(1,1,:)=sin(angs);v1(2,1,:)=-cos(angs);
% v0=[cos(curra);sin(curra)];
% v1=[sin(curra);-cos(curra)];
V=(zeros(2,2,onum));
V(:,1,:)=v0;V(:,2,:)=v1;
% V=[v0,v1];
% M_1=pagefun(@mtimes,V,D);
% M_2=pagefun(@mtimes,M_1,D);
% M=pagefun(@mtimes,M_2,permute(V,[2,1,3]));
M=zeros(2,2,size(K,2));
for ii=1:size(K,2)
    M(:,:,ii)=V(:,:,ii)*D(:,:,ii)*D(:,:,ii)*V(:,:,ii)';
end