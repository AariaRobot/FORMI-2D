function [cells,locpath,indpath,neighbours]=findbaseroute_ellver(start,goal,obst,lims,maxdepth,maxrads,disttogoal,startdepth,gridsizemult,gridsizepow,M,prefw)
prefwperlims=prefw/min(diff(lims,[],2));
prefw=length(dec2bin(1/prefwperlims));
cells=celldecomp_ellver(obst,startdepth,lims(1,:),lims(2,:),maxrads,M);
nbs=findallneighbours(cells,lims);
neighbours=nbs;
tempcells=cells;
tempcells(4,:)=tempcells(4,:)*0;
nbs_obstless=findallneighbours(tempcells,lims);
olnbs=nbs_obstless;
% % figure(2)
% % clf
% % plotcells(cells,lims);
% hold on
% plot(obst(1,:),obst(2,:),'r.')
% hold off
startind = findcellind_2(cells,start,lims);
goalind = findcellind_2(cells,goal,lims);
% indpath = cdastar(cells,startind,goalind,xlims,ylims);
% indpath = cdastar_withnbs(cells,startind,goalind,lims(1,:),lims(2,:),nbs);
indpath = cdastar_withnbs(cells,startind,goalind,lims(1,:),lims(2,:),nbs,gridsizemult,gridsizepow,prefw);
% figure(3)
% clf
% % original maximum depth
% origmd=maxdepth;
% hold on
newcells=cells;
newcells(4,:)=-1*newcells(4,:);
ii=0;
while isempty(indpath)
    tempcells = newcells;
    ii=ii+1;
% %     disp(['iterations: ',int2str(ii)]);
% %     drawnow
% % % %     current maximum depth
% % %     cmd=max(cells(1,:));
% % % %     finding the cells at maximum depth
% % %     deepcells=find(cells(1,:)==cmd);
% % %     finding the cells at or below the original maximum depth
%     deepcells=find(newcells(1,:)>origmd);
%     tempcells(4,deepcells)=zeros(size(tempcells(4,deepcells)));
    possfreeinds=tempcells(4,:)==-1;
    tempcells(4,possfreeinds)=0*tempcells(4,possfreeinds);
    tempcells(4,:)=abs(tempcells(4,:));
%     temppath = cdastar(tempcells,startind,goalind,xlims,ylims);
%     temppath = cdastar_withnbs(tempcells,startind,goalind,xlims,ylims,nbs_obstless);
    temppath = cdastar_withnbs(tempcells,startind,goalind,lims(1,:),lims(2,:),olnbs,gridsizemult,gridsizepow,prefw);
    if isempty(temppath)
        indpath=[];
        locpath=[];
        break;
    end
%     figure(3);clf;plotcells(tempcells,lims);hold on;currx=tempcells(2,temppath);
%     curry=tempcells(3,temppath);
%     plot(currx,curry,'r');axis equal;hold off
%     temppath = cdastar_withnbs_goaldist(tempcells,startind,goalind,lims(1,:),lims(2,:),olnbs,disttogoal,goal);
% %     hold on
% %     plot(tempcells(2,temppath),tempcells(3,temppath),'r')
% %     hold off
    ocls=newcells;
    [newcells,improvedinds,newinds] = improvepathprec_withnbs_ellver(newcells,temppath,obst,lims,maxdepth,maxrads,M);
%     neighbours=nbs;

%     nbs=findallneighbours(newcells,lims);

    neighbours=findallneighbours_fast(newcells,lims,newinds,improvedinds,neighbours);
%     if ii==13
%         disp('stop')
%     end

%     nbs=neighbours;
% %     nbs(improvedinds)=[];
    tempcells=newcells;
    possfreeinds=tempcells(4,:)==-1;
    tempcells(4,possfreeinds)=0*tempcells(4,possfreeinds);
    tempcells(4,:)=abs(tempcells(4,:));
%     tempcells(4,:)=tempcells(4,:)*0;
    
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
%     indpath = cdastar_withnbs(tempcells,startind,goalind,lims(1,:),lims(2,:),neighbours);
%     figure(4);plotcells(tempcells,lims);hold on;
%     plot(currx,curry,'r');axis equal;hold off
    indpath = cdastar_withnbs(tempcells,startind,goalind,lims(1,:),lims(2,:),neighbours,gridsizemult,gridsizepow,prefw);
% %     startind = findcellind(newcells,start);
% %     goalind = findcellind(newcells,goal);
% %     indpath = cdastar(newcells,startind,goalind,xlims,ylims);
%     if ii==5
%         disp('stop')
%     end
%     currname = ['hfcells',num2str(ii)];
%     save(currname,'newcells');
end
% hold off
% [newcells,success] = improveprec(cells,cellind,obstacles,lims,maxdepth);
if ~isempty(indpath)
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
    locpath(:,end) = newcells(2:3,indpath(end));
end
% locpath(:,end) = goal;
cells=newcells;
% locpath=cells(2:3,indpath);
% % hold on
% % plot(locpath(1,:),locpath(2,:),'b')
% % % plot(cells(2,1:12),cells(3,1:12),'r.')
% % hold off