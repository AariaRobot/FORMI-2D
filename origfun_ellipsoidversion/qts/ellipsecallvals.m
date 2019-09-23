lims=[0,3;0,3];
rng(0)
rad=0.15;
onum=90;
obst=rand(2,onum).*(diff(lims')'*ones(1,onum));
angs=rand(1,onum).*2*pi;
xws=(rand(1,onum)+1)*rad/1.5;
yws=(rand(1,onum)+1)*rad/1.5;

% gobst=gpuArray(obst);
% gangs=gpuArray(angs);
% gxws=gpuArray(xws);
% gyws=gpuArray(yws);
% 
% [K,M]=findellipseparams(gobst,gxws,gyws,gangs);
% point=gpuArray(rand(2,1).*diff(lims')');
% resvec=ispointinell_gv(M,K,point);
[K,M]=findellipseparams_ng(obst,xws,yws,angs);
point=rand(2,1).*diff(lims')';
resvec=ispointinell_vecver(M,K,point);
resvec=ispointinell_vecver(M,K,p0);
rv1=[];
M2=zeros(size(M));
V2=zeros(size(V));
for ii=1:length(resvec)
    [rv1(ii),M2(:,:,ii),V2(:,:,ii)]=ispointinell(obst(:,ii),xws(ii),yws(ii),angs(ii),p0);
end
rv2=[];
for ii=tempresvec%1:onum
    m=M(:,:,ii);
    k=K(:,ii);
%     if max(ii==tempresvec)
%         disp('stop')
%     end
    res=edge_ell_int(m,k,p0,p1);
    rv2(ii)=res;
end
% tempresvec=find(rv2)
find(rv2)
figure(1);hold on;plot(K(1,logical(rv2)),K(2,logical(rv2)),'r.');hold off
% x^2/a^2+y^2/b^2=1
% x^2=a^2*(1-y^2/b^2)

% currol=obst(:,1);
% currxw=xws(1);curryw=yws(1);curra=angs(1);
angs=-angs;
t=[0:0.01:2*pi,NaN];
[allxws,allts]=meshgrid(xws,t);
allyws=meshgrid(yws,t);
allas=meshgrid(angs,t);
allxls=meshgrid(obst(1,:),t);
allyls=meshgrid(obst(2,:),t);
aaxs = allxws.*cos(allts);
aays = allyws.*sin(allts);

% plot(aaxs(:),aays(:),'b');axis equal

rxs = aaxs.*cos(allas)+aays.*sin(allas);
rys = aays.*cos(allas)-aaxs.*sin(allas);

% plot(rxs(:),rys(:),'b');axis equal

xgrid = rxs+allxls;
ygrid = rys+allyls;

y=ygrid(:);x=xgrid(:);
% x=currxw*cos(t);%+currol(1);
% y=curryw*sin(t);%+currol(2);
% rx=x*cos(curra)+y*sin(curra);
% ry=y*cos(curra)+x*sin(curra);
% x=rx+currol(1);
% y=ry+currol(2);
plot(x,y,'b');axis equal
hold on;plot(point(1),point(2),'r.');hold off

% rotmats=zeros(2,2,onum);
% rotmats(1,1,:)=cos(angs);
% rotmats(1,2,:)=sin(angs);
% rotmats(2,1,:)=-sin(angs);
% rotmats(2,2,:)=cos(angs);