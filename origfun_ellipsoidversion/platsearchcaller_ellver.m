function [locpath,cells,runtime]=platsearchcaller_ellver(start,goal,obst,lims,maxdepth,maxrads,figurenums,startdepth,gridsizemult,gridsizepow,M,xws,yws,angs,prefw)
%% find initial mobile base route
if ~exist('prefw','var')
    prefw=Inf;
end
tic;
[cells,locpath,indpath,nbs]=findbaseroute_ellver(start,goal,obst,lims,maxdepth,maxrads,0,startdepth,gridsizemult,gridsizepow,M,prefw);
if ~isempty(locpath)
    locpath(:,end)=goal;
    runtime=toc;
    %% plot the results:
    % plotter_simplified(obst,rad,locpath,cells,lims,figurenums,smoothpath)
    plotter_simplified_ellver(obst,locpath,cells,lims,figurenums,xws,yws,angs)
else
    runtime=toc;
    plotter_simplified_ellver(obst,start,cells,lims,figurenums,xws,yws,angs)
end