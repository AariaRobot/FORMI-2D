function newpath=pathprecimp(origpath,ppp)
% ppp=2;
% origpath=indpath_manip;
% figure(4)
% plot(origpath(1,:),origpath(2,:),'b.')
% axis equal

% opl=size(origpath,2);
% tvals = linspace(1,opl,opl);

opdiffs=sqrt(sum(diff(origpath,1,2).^2));

tvals=[0,cumsum(opdiffs)];
newqvals=linspace(0,tvals(end),ceil(tvals(end)*ppp)+1);

ipx=interp1(tvals,origpath(1,:),newqvals);
ipy=interp1(tvals,origpath(2,:),newqvals);
newpath=[ipx;ipy];