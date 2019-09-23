function [obst,start,goal,xws,yws,angs]=makeflytrap(lims)
% mapmaking:
% flytrap:
start = [0.2;0.5];
goal = [0.8;0.5];
% obl1 = [ones(1,6)*0.5;linspace(0.3,0.7,6)];
% obl1 = [ones(1,4)*0.5;linspace(0.38,0.62,4)];
obl1 = [ones(1,4)*0.58;linspace(0.38,0.62,4)];
obl2 = [linspace(0.3,0.5,5);ones(1,5)*0.3];
obl3 = [linspace(0.3,0.5,5);ones(1,5)*0.7];
obst = [obl1,obl2,obl3]-[0.15;0];
% figure(1);clf;axis equal;plot(start(1),start(2),'g.');hold on
% plot(goal(1),goal(2),'r.');plot(obst(1,:),obst(2,:),'k.');hold off
% xlim([0,1]);ylim([0,1]);
xws = 0.1*ones(1,size(obst,2));
% xws = 0.01*ones(1,size(obst,2));
yws = 0.02*ones(size(xws));
% yws = 0.008*ones(size(xws));
angs = [pi/2*ones(1,size(obl1,2)),zeros(1,size(obst,2)-size(obl1,2))];

obst = obst.*(diff(lims,1,2)*ones(1,size(obst,2)))+lims(:,1);
xws = xws.*(diff(lims(1,:))*ones(1,size(xws,2)));
yws = yws.*(diff(lims(2,:))*ones(1,size(xws,2)));
start = start.*diff(lims,1,2)+lims(:,1);
goal = goal.*diff(lims,1,2)+lims(:,1);