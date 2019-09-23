function [res,M,V]=ispointinell(currol,currxw,curryw,curra,testpoint)
% currol=obst(:,1);
% currxw=xws(1);curryw=yws(1);curra=angs(1);

% isinell:
D=diag([1/currxw,1/curryw]);
v0=[cos(curra);sin(curra)];
v1=[sin(curra);-cos(curra)];
V=[v0,v1];
M=V*D^2*V';
if (testpoint-currol)'*M*(testpoint-currol)<1
    res=true;
else
    res=false;
end

% if norm((D*V'*(testpoint-currol)))<1
%     res=true;
% else
%     res=false;
% end