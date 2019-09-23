function route=backtrackroute(cg,mapsize)
[x,y]=ind2sub(mapsize,cg(1,end));
route=[x;y];
currel=cg(:,end);
while currel(1)~=cg(1,1)
    [~, pind]=min(abs(cg(1,:)-currel(3)));
    currel=cg(:,pind);
    [x,y]=ind2sub(mapsize,currel(1));
    route=[[x;y],route];
end