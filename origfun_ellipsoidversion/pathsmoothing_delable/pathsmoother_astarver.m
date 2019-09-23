function smoothpath=pathsmoother_astarver(locpath,ocg,lims,startipm,smoothmult,discprec)
% maxdepth=max(cells(1,:));
coll=true;
if ~exist('startipm','var')
    startipm = 0.125;
end
if ~exist('smoothmult','var')
    smoothmult=100;%10;%
end
origpath=locpath;
[currpath,qvals]=interpolatepath(origpath,startipm);
while coll
    smoothpath=splinesmoothing(currpath,smoothmult);
    occupancyvector=pathcc_astarver(smoothpath,ocg,lims,discprec);
    if sum(occupancyvector)>0
%         curripm=curripm*2;
        [currpath,qvals]=partialinterp(origpath,occupancyvector,smoothmult,qvals);
    else
        coll=false;
    end
end