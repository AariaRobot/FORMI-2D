% save('locpath','locpath')
% load locpath
% smoothing parameter sp: 0 -> locpath, 1 -> 'normal' spline
sp=1;%0.5;%
tvals=linspace(1,size(locpath,2),size(locpath,2));
smpxf=csaps(tvals,locpath(1,:),sp);
smpyf=csaps(tvals,locpath(2,:),sp);
qvals=linspace(tvals(1),tvals(end),length(tvals)*10);
smpx=fnval(smpxf,qvals);
smpy=fnval(smpyf,qvals);

% smoothedpath=csaps(locpath(1,:),locpath(2,:),sp);
% [smoothedpath,sp]=csaps(locpath(1,:),locpath(2,:));
figure(1)
clf
hold on
% fnplt(smoothedpath);
plot(locpath(1,:),locpath(2,:),'b');
plot(smpx,smpy,'r')

hold off;axis equal