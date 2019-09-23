function [obst,start,goal,xws,yws,angs]=makemaze(lims)
% mapmaking:
% maze:
start = [0.1;0.9];
goal = [0.9;0.9];
obl1 = [ones(1,11)*0.5;linspace(0.3,1,9),linspace(0,0.1,2)];
obst=obl1;
% obst = [obl1,obl2];%,obl3];%-[0.15;0];
% figure(1);clf;axis equal;plot(start(1),start(2),'g.');hold on
% plot(goal(1),goal(2),'r.');plot(obst(1,:),obst(2,:),'k.');hold off
% xlim([0,1]);ylim([0,1]);
xws = 0.05*ones(1,size(obst,2));
yws = 0.05*ones(size(xws));%0.01*ones(size(xws));
angs = pi/2*ones(1,size(obst,2));%[pi*ones(1,size(obl1,2)),zeros(1,size(obst,2)-size(obl1,2))];

obst = obst.*(diff(lims,1,2)*ones(1,size(obst,2)))+lims(:,1);
xws = xws.*(diff(lims(1,:))*ones(1,size(xws,2)));
yws = yws.*(diff(lims(2,:))*ones(1,size(xws,2)));
start = start.*diff(lims,1,2)+lims(:,1);
goal = goal.*diff(lims,1,2)+lims(:,1);