function [newcells,success,extracells] = improveprec_ellver(cells,cellind,obstacles,lims,maxdepth,maxrads,M)
% rad=0.005;%0.05;
currcell=cells(:,cellind);
depth=currcell(1);
steps=[1,1,-1,-1;
    1,-1,-1,1];
xdiff=(lims(1,2)-lims(1,1))/(2^depth);
ydiff=(lims(2,2)-lims(2,1))/(2^depth);
bb=steps.*[xdiff;ydiff];
bb=bb./2;
% depth=currcell(1);
% maxdepth=Inf;
statuses=zeros(1,4);
depths=ones(1,4)*depth+1;
locs=zeros(2,4);
for ii=1:4
    ploc=currcell(2:3)+steps(:,ii)./2.*[xdiff;ydiff];
    locs(:,ii)=ploc;
    currbb=bb+ploc;
%     plot(ploc(1),ploc(2),'b.')
%     plot(bb(1,:),bb(2,:),'r')
    statuses(ii)=bbcheck_ellver(currbb,obstacles,maxrads,M,depth,maxdepth);
end
if abs(sum(statuses))==4
    success=false;
else
    success=true;
end
newcells=[cells(:,1:cellind-1),cells(:,cellind+1:end),[depths;locs;statuses]];
extracells=[depths;locs;statuses];