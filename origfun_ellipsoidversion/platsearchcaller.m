function platsearchcaller(start,goal,obst,lims,maxdepth,rad,figurenums,startdepth,gridsizemult,gridsizepow)
%% find initial mobile base route
[cells,locpath,indpath,nbs]=findbaseroute(start,goal,obst,lims,maxdepth,rad,0,startdepth,gridsizemult,gridsizepow);
locpath(:,end)=goal;
%% smooth the mobile base route:
ocg=ocggen(cells,lims);
smoothpath=pathsmoother(locpath,ocg,lims,1/8,100);
%% plot the results:
plotter_simplified(obst,rad,locpath,cells,lims,figurenums,smoothpath)