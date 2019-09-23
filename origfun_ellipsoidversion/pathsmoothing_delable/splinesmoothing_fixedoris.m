function smoothpath=splinesmoothing_fixedoris(origpath,mult,startori,goalori)
% mult determines how many points are picked from the spline for each point
% in the original path.
% sp=1;%0.5;%
% total path length
% tpl=sum(sqrt(sum(diff(origpath,1,2).^2)));

tvals=[0,cumsum(sqrt(sum(diff(origpath,1,2).^2)))];
% tvals=linspace(1,tpl,size(origpath,2));
% tvals=linspace(1,size(origpath,2),size(origpath,2));
% % tvals(end)=tvals(end-1)+1e-1;

% mult=mult*length(tvals)/(length(tvals)-1);
qsv=linspace(0,1-1/mult,mult);
% size(qsv)
% if size(tvals,2)==1
%     disp('stop')
% end
tq=(qsv'*diff(tvals));
tqa=ones(mult,1)*tvals(1:end-1);
qvals=tqa(:)+tq(:);
qvals=qvals';

% qvals=linspace(tvals(1),tvals(end),length(tvals)*mult);

% smpx=spline(tvals,[path(1,1)-startori(1),path(1,:),path(1,end)+goalori(1)],qvals);
% size(origpath,2)
% if size(origpath,2)>190%==200
%     disp('stop')
% end
smpx=spline(tvals,[startori(1),origpath(1,:),goalori(1)],qvals);
smpy=spline(tvals,[startori(2),origpath(2,:),goalori(2)],qvals);
% figure(3);clf;hold on;plot(tvals,origpath(1,:),'r.');plot(qvals,smpx,'b');hold off
% figure(4);plot(smpx,smpy,'r');axis equal
% smpy=spline(tvals,[path(2,1)-startori(2),path(2,:),path(2,end)+goalori(2)],qvals);
% smpx=fnval(smpxf,qvals);
% smpy=fnval(smpyf,qvals);
smoothpath=[smpx;smpy];