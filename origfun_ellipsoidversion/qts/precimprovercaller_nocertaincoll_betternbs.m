% obst=rand(2,10)*3;
% rng(2133);
% obst=rand(2,50)*3;
rng(2155);
obst=rand(2,500)*3;

% load('obst')
xlims=[0,3];ylims=[0,3];
% maxdepth=5;
% maxdepth=15;
maxdepth=3;
% maxdepth=2;
cells=celldecomp(obst,maxdepth,xlims,ylims);
lims=[xlims;ylims];
nbs=findallneighbours(cells,lims);
neighbours=nbs;
tempcells=cells;
tempcells(4,:)=tempcells(4,:)*0;
nbs_obstless=findallneighbours(tempcells,lims);
olnbs=nbs_obstless;
figure(2)
clf
plotcells(cells,lims);
% hold on
% plot(obst(1,:),obst(2,:),'r.')
% hold off
start = [0.9;0.2];
goal = [2.1;2.8];
startind = findcellind_2(cells,start,lims);
goalind = findcellind_2(cells,goal,lims);
% indpath = cdastar(cells,startind,goalind,xlims,ylims);
indpath = cdastar_withnbs(cells,startind,goalind,xlims,ylims,nbs);
% figure(3)
% clf
% original maximum depth
origmd=maxdepth;
% hold on
newcells=cells;
ii=0;
while isempty(indpath)
    tempcells = newcells;
    ii=ii+1;
    disp(['iterations: ',int2str(ii)]);
    drawnow
% % % %     current maximum depth
% % %     cmd=max(cells(1,:));
% % % %     finding the cells at maximum depth
% % %     deepcells=find(cells(1,:)==cmd);
% % %     finding the cells at or below the original maximum depth
%     deepcells=find(newcells(1,:)>origmd);
%     tempcells(4,deepcells)=zeros(size(tempcells(4,deepcells)));
    tempcells(4,:)=0*tempcells(4,:);
%     temppath = cdastar(tempcells,startind,goalind,xlims,ylims);
%     temppath = cdastar_withnbs(tempcells,startind,goalind,xlims,ylims,nbs_obstless);
    temppath = cdastar_withnbs(tempcells,startind,goalind,xlims,ylims,olnbs);
    hold on
    plot(tempcells(2,temppath),tempcells(3,temppath),'r')
    hold off
    ocls=newcells;
    [newcells,improvedinds,newinds] = improvepathprec_withnbs(newcells,temppath,obst,lims,maxdepth);
%     neighbours=nbs;

%     nbs=findallneighbours(newcells,lims);

    neighbours=findallneighbours_fast(newcells,lims,newinds,improvedinds,neighbours);
%     if ii==13
%         disp('stop')
%     end

%     nbs=neighbours;
% %     nbs(improvedinds)=[];
    tempcells=newcells;
    tempcells(4,:)=tempcells(4,:)*0;
    
%     nbs_obstless=findallneighbours(tempcells,lims);

    olnbs=findallneighbours_fast(tempcells,lims,newinds,improvedinds,olnbs);
% %     nbs_obstless(improvedinds)=[];
%     newcells = improvepathprec(newcells,temppath,obst,lims,maxdepth);
% %     nbs=appendneighbours(nbs,newcells,lims);
% %     nbs_obstless = appendneighbours(nbs_obstless,tempcells,lims);
    
    tempcells = newcells;
    tempcells(4,:) = abs(tempcells(4,:));
    startind = findcellind_2(tempcells,start,lims);
    goalind = findcellind_2(tempcells,goal,lims);
%     indpath = cdastar(tempcells,startind,goalind,xlims,ylims);
%     indpath = cdastar_withnbs(tempcells,startind,goalind,xlims,ylims,nbs);
    indpath = cdastar_withnbs(tempcells,startind,goalind,xlims,ylims,neighbours);
% %     startind = findcellind(newcells,start);
% %     goalind = findcellind(newcells,goal);
% %     indpath = cdastar(newcells,startind,goalind,xlims,ylims);
%     if ii==5
%         disp('stop')
%     end
end
% hold off
% [newcells,success] = improveprec(cells,cellind,obstacles,lims,maxdepth);
locpath=zeros(2,length(indpath)+1);
% locpath(:,1)=cells(2:3,indpath(1));
% locpath(:,1) = newcells(2:3,indpath(1));
locpath(:,1) = start;
% for ii=2:length(indpath)-1
for ii=1:length(indpath)-1
%     locpath(:,ii) = findecp(cells,indpath(ii),indpath(ii+1),lims);
    locpath(:,ii+1) = findecp(newcells,indpath(ii),indpath(ii+1),lims);
end
% locpath(:,end)=cells(2:3,indpath(end));
% locpath(:,end) = newcells(2:3,indpath(end));
% locpath(:,end) = newcells(2:3,indpath(end));
locpath(:,end) = goal;
% locpath=cells(2:3,indpath);
% % hold on
% % plot(locpath(1,:),locpath(2,:),'b')
% % % plot(cells(2,1:12),cells(3,1:12),'r.')
% % hold off
figure(3)
clf
% plotcells(newcells,lims);
plotcells(tempcells,lims);
% hold off
hold on
plot(obst(1,:),obst(2,:),'r.')
plot(locpath(1,:),locpath(2,:),'b')
plot(locpath(1,:),locpath(2,:),'b.')
hold off