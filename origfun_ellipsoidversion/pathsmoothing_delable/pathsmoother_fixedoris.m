function smoothpath=pathsmoother_fixedoris(locpath,ocg,lims,startipm,smoothmult,startori,goalori)
% maxdepth=max(cells(1,:));
coll=true;
if ~exist('startipm','var')
    startipm = 0.125;
end
if ~exist('smoothmult','var')
    smoothmult=100;%10;%
end
origpath=locpath;
% [currpath,qvals]=interpolatepath(origpath,startipm);
qvals=[1,size(origpath,2)];
currpath=[origpath(:,1),origpath(:,end)];
while coll
    smoothpath=splinesmoothing_fixedoris(currpath,smoothmult,startori,goalori);
%     sp2=splinesmoothing(currpath,smoothmult);
%     figure(2);hold on;plot(sp2(1,:),sp2(2,:),'r');hold off
%     figure(2);hold on;plot(smoothpath(1,:),smoothpath(2,:),'b');hold off
    occupancyvector=pathcc(smoothpath,ocg,lims);
%     figure(4);plot(smoothpath(1,:),smoothpath(2,:),'r');axis equal
%     hold on;plot(smoothpath(1,occupancyvector),smoothpath(2,occupancyvector),'b.');hold off
%     figure(2);hold on;plot(smoothpath(1,:),smoothpath(2,:),'r');axis equal
%     plot(smoothpath(1,occupancyvector),smoothpath(2,occupancyvector),'b.');
%     plot(currpath(1,:),currpath(2,:),'r.');hold off
    if sum(occupancyvector)>0
%         curripm=curripm*2;
        [currpath,qvals]=partialinterp_fixedoris(origpath,occupancyvector,smoothmult,qvals);
    else
        coll=false;
    end
end