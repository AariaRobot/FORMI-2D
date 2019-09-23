load locpath
load cellsandlims
load occupancygrid
maxdepth=max(cells(1,:));
coll=true;
curripm = 0.125;
smoothmult=100;%10;%
origpath=locpath;
[currpath,qvals]=interpolatepath(origpath,curripm);
while coll
    smoothpath=splinesmoothing(currpath,smoothmult);
    occupancyvector=pathcc(smoothpath,ocg,lims,maxdepth);
    if sum(occupancyvector)>0
%         curripm=curripm*2;
        [currpath,qvals]=partialinterp(origpath,occupancyvector,smoothmult,qvals);
    else
        coll=false;
    end
end
figure(1)
clf
hold on
plot(origpath(1,:),origpath(2,:),'b.')
% currpath=origpath(:,1:end-1)+ipsums./2;
% currpath=ippath;
currpath=smoothpath;
plot(currpath(1,:),currpath(2,:),'r.')
hold off
axis equal
% save('smoothpath','smoothpath')