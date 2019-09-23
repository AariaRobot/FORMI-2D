function smoothpath=pathsmoother(locpath,ocg,lims,startipm,smoothmult)
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
    smoothpath=splinesmoothing(currpath,smoothmult);
    occupancyvector=pathcc(smoothpath,ocg,lims);
    if sum(occupancyvector)>0
%         curripm=curripm*2;
        [currpath,qvals]=partialinterp(origpath,occupancyvector,smoothmult,qvals);
    else
        coll=false;
    end
end