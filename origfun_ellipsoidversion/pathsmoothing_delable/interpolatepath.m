function [ippath,qtvals]=interpolatepath(origpath,ipcount)
% load locpath
% ipcount is an integer, stating how many times each path point is multiplied.
% origpath=locpath;
tvals = [0,cumsum(sqrt(sum(diff(origpath,1,2).^2)))];
opl = sum(sqrt(sum(diff(origpath,1,2).^2)));
% opl = size(origpath,2);

% t-values used for the original path
% tvals = linspace(1,opl,opl);
% t-values used for the queried path. The minimum number of query values is
% two, the starting point and the end point.
qtvals = linspace(0,opl,max(round(size(origpath,2)*ipcount),2));
% tvals = linspace(0,opl,opl);
% ipx=interp1(tvals,origpath(1,:),qtvals);
% ipy=interp1(tvals,origpath(2,:),qtvals);
ipx = interp1(tvals,origpath(1,:),qtvals);
ipy = interp1(tvals,origpath(2,:),qtvals);
ippath = [ipx;ipy];
% qtvals = linspace(0,opl,round(opl*ipcount));
% ipsums=[diff(origpath(1,:));diff(origpath(2,:))];
% if ipcount==1
%     currpath=origpath(:,1:end-1)+ipsums./2;
%     ippath=[origpath(:,1),currpath,origpath(:,end)];
% end


% figure(1)
% clf
% hold on
% plot(origpath(1,:),origpath(2,:),'b.')
% % currpath=origpath(:,1:end-1)+ipsums./2;
% currpath=ippath;
% plot(currpath(1,:),currpath(2,:),'r.')
% hold off
% axis equal
