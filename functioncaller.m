% the main caller function:
%% set paths:
oldpath=path();
path(oldpath,'astar_floatocg_ellver');currpath=path();
path(currpath,'astar_floatocg_ellver/newsearch');currpath=path();
path(currpath,'astar_floatocg_ellver/search_8dir');currpath=path();
path(currpath,'astar_floatocg_ellver/collprobgen');currpath=path();
path(currpath,'origfun_ellipsoidversion');currpath=path();
path(currpath,'origfun_ellipsoidversion/qts');currpath=path();
path(currpath,'prob_ocg_gen')
midpath=path();
%% initialize values
% obst=rand(2,10)*3;
% rad=5e-2;
% rng(50);
rng(5);
% rng(0);
% obst=rand(2,90)*3;
% manipsm=15e-2;
xlims=[0,3];
ylims=[0,3];
lims=[xlims;ylims]*10;
% maxdepth=2;
% start = [0.9;0.2];
% start = [0.9;0.5];
% start = [1;0.5];
% start = [1;2];
% start = [1;2.2];
start = [0.5;2.5]*10;
% start = [1.4;2.4];
% start = [3.5;2];
goal = [2.1;1.5]*10;
% goal = [0.5;2];
% goal = [2.1;2.8];
% goal = [1.4;2.9];

rad=0.15*10;
rad2=0.12*10;
onum=90;
obst=rand(2,onum).*(diff(lims')'*ones(1,onum))*1;
angs=rand(1,onum).*2*pi;
xws=(rand(1,onum)+1)*rad2/1.5*1;
yws=(rand(1,onum)+1)*rad2/1.5*1;

maptype='orig';

% [obst,start,goal,xws,yws,angs]=makemaze(lims);
% maptype='maze';

% [obst,start,goal,xws,yws,angs]=makeflytrap(lims);
% maptype = 'flytrap';

rng(0);
xws=xws+rand(size(xws))*2e-2;
yws=yws+rand(size(yws))*2e-2;
angs=angs+rand(size(angs))*2e-2;
obst=obst+rand(size(obst))*2e-2;
start=start+rand(size(start))*2e-2;
goal=goal+rand(size(goal))*2e-2;

maxrads=max([xws;yws]);

[~,M]=findellipseparams_ng(obst,xws,yws,angs);


discprec_astar = 0.02*10;% 0.05 for large maps, 0.02 for the small one(s)
fignums_binastar=1;
fignums_astar=2;
fignums_qtfun = [1,2]+2;
fignums_origfun = [1,2]+4;
startdepth=2;
maxdepth=7;
gridsizemult=50;
gridsizepow=1;

astarver=4;%1 -> grid squares are checked against ellipses,
% 2 -> gs centers are checked against probability function density,
% 3 -> circular probabilities are used, 4 -> ellipse probabilities are used
% obstcost is the multiplier for the penalty function in soft obstacle cost
% a*
obstcost = 1;%10;%1e100;% % obstacle cost multiplier for floating-point version of a*
% ocp is the sigma of the gaussian used in the soft obstacle cost a*
ocp = 0.05;%2;%1; % obstacle cost power for fp a*


ellproblim=0.95;
sigmafactor=chi2inv(ellproblim,2);%chi2pdf backwards
sigmas=ellstocovs(xws,yws,angs,sigmafactor);
prefw=0.05*10;
%% Dijkstra's algorithm on a probabilistic grid
[astarpath,ocg,astime,as_ccs]=astarcaller(obst, discprec_astar, rad, lims, start, goal, fignums_astar, 5, obstcost, ocp, xws, yws, angs, maxrads, M, sigmas);
%% astar on a binary grid:
[binastarpath,binocg,bastime,bascclocinds]=astarcaller(obst, discprec_astar, rad, lims, start, goal, fignums_binastar, 6, obstcost, ocp, xws, yws, angs, maxrads, M, sigmas);
%% astar on a quadtree:
[normqtlocpath,normcells,normqttime]=platsearchcaller_ellver(start,goal,obst,lims,maxdepth,maxrads,fignums_qtfun,maxdepth,gridsizemult,gridsizepow,M,xws,yws,angs,prefw);
%% FORMI:
[qtlocpath,cells,qttime]=platsearchcaller_ellver(start,goal,obst,lims,maxdepth,maxrads,fignums_origfun,startdepth,gridsizemult,gridsizepow,M,xws,yws,angs,prefw);
%% resetting the path:
path(oldpath)