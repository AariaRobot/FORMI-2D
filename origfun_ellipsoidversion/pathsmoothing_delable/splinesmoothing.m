function smoothpath=splinesmoothing(path,mult)
% mult determines how many points are picked from the spline for each point
% in the original path.
sp=1;%0.5;%
tvals=linspace(1,size(path,2),size(path,2));
smpxf=csaps(tvals,path(1,:),sp);
smpyf=csaps(tvals,path(2,:),sp);
qvals=linspace(tvals(1),tvals(end),length(tvals)*mult);
smpx=fnval(smpxf,qvals);
smpy=fnval(smpyf,qvals);
smoothpath=[smpx;smpy];