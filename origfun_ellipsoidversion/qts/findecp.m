function [ecp,success] = findecp(cells,ind1,ind2,lims)
% function for finding the center point of an edge between two cells
cell1=cells(:,ind1);
cell2=cells(:,ind2);
xmult=lims(1,2)-lims(1,1);
ymult=lims(2,2)-lims(2,1);
xstep1=xmult/2^cell1(1);
xstep2=xmult/2^cell2(1);
ystep1=ymult/2^cell1(1);
ystep2=ymult/2^cell2(1);
dirs=[[-1,1,0,0];...
    [0,0,-1,1];...
    [1,-1,0,0];...
    [0,0,1,-1]];
steps=[xstep1;ystep1;xstep2;ystep2];
locs=[cell1(2:3);cell2(2:3)];
newlocs=dirs.*steps+locs;
dists=[newlocs(1,1)-newlocs(3,1),newlocs(1,2)-newlocs(3,2),newlocs(2,3)-newlocs(4,3),newlocs(2,4)-newlocs(4,4)];
[stepdist,stepind]=min(abs(dists));
if stepdist==0
    success=true;
    [~,cellnum]=max([cell1(1),cell2(1)]);
    dirinds=[cellnum*2-1,cellnum*2];
    ecp=newlocs(dirinds,stepind);
else
    success=false;
    ecp=[0;0];
end
