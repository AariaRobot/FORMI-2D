%% set paths
oldpath=path();
path(oldpath,'qts');currpath=path();
path(currpath,'pathsmoothing')
% path(oldpath,'manipsearch');currpath=path();
% path(currpath,'pathsmoothing');currpath=path();path(currpath,'qts')
% midpath=path();
%% initialize values
% obst=rand(2,10)*3;
% rng(2133);
rng(0);
% obst=rand(2,50)*3;
% rng(2155);
% obst=rand(2,500)*3;
% obst=rand(2,90)*3;
% rad=0.15;
rad=0.12;
xlims=[0,3];ylims=[0,3];
lims=[xlims;ylims];
onum=90;
obst=rand(2,onum).*(diff(lims')'*ones(1,onum));
angs=rand(1,onum).*2*pi;
xws=(rand(1,onum)+1)*rad/1.5;
yws=(rand(1,onum)+1)*rad/1.5;
maxrads=max([xws;yws]);
[~,M]=findellipseparams_ng(obst,xws,yws,angs);
% manipulator size multiplier
% manipsm=15e-2;%1e-3;%10e-2;%
% load('obst')
% maxdepth=5;
% maxdepth=15;
% maxdepth=3;
startdepth=2;
maxdepth=9;
% start = [0.9;0.2];
start = [0.9;0.5];
% goal = [2.1;1.5];
goal = [2.1;2.8];
% goal = [1.4;2.9];
% rad=0.15;
% rad=5e-2;
figurenums=[1,2,3];

% gridsizemult=50;
gridsizemult=0;
gridsizepow=1;

%% find the mobile base route for the ellipse version:
[cells,locpath,indpath,nbs]=findbaseroute_ellver(start,goal,obst,lims,maxdepth,maxrads,0,startdepth,gridsizemult,gridsizepow,M);
% %% find initial mobile base route
% [cells,locpath,indpath,nbs]=findbaseroute(start,goal,obst,lims,maxdepth,rad,0,startdepth,gridsizemult,gridsizepow);
locpath(:,end)=goal;
%% smooth the mobile base route:
ocg=ocggen(cells,lims);
smoothpath=pathsmoother(locpath,ocg,lims,1/8,100);
%% plot the results:
% plotter_simplified_ellver(obst,rad,locpath,cells,lims,figurenums,smoothpath)
plotter_simplified_ellver(obst,locpath,cells,lims,figurenums,smoothpath,xws,yws,angs)
%% reset the path:
path(oldpath);