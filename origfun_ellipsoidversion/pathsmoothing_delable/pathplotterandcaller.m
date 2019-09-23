% fullpathsmoothingcaller
load locpath
% load occupancygrid
load cellsandlims
ocg=ocggen(cells,lims);
smoothpath=pathsmoother(locpath,ocg,lims,1/8,100);
oldpath = path;
path(oldpath,'\\intra.tut.fi\home\maenpaa9\My Documents\tyajutut\robomaniprokkis\intalsearch_mobbase_and_manip\qts')
% path(oldpath,'qts');
figure(1)
clf
plotcells(cells,lims)
hold on
plot(locpath(1,:),locpath(2,:),'b.')
plot(smoothpath(1,:),smoothpath(2,:),'r')
hold off
path(oldpath);
