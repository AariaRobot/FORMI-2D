function indpath=cdastar_withnbs_goaldist(cells,startind,endind,xlims,ylims,nbs,goaldist,goal,gridsizemult,gridsizepow)
% node contents: cell index, parent cell index, cost from start, estimated
% cost to goal
goalloc=cells(2:3,endind);
openset=[startind;0;0;norm(goalloc-cells(2:3,startind))];
closedset=[];
goalfound=0;
% if startind==endind
if cells(4,startind)~=0||cells(4,endind)~=0
    openset=[];
end
% iters=0;
while ~isempty(openset)&&~goalfound
%     iters=iters+1
    [currnode,openset]=pop(openset);
    closedset=[closedset,currnode];
    neighbourinds=nbs{currnode(1)};
    for ii=1:length(neighbourinds)
        cnbind=neighbourinds(ii);
        if min(abs(closedset(1,:)-cnbind))~=0
            openset=appendos(openset,cnbind,currnode,cells,goalloc);
        end
    end
    if closedset(1,end)==endind%goalcheck(cells(:,closedset(1,end)),[xlims;ylims],goaldist,goal)
        goalfound=1;
%         plotcells(cells,[xlims;ylims])
%         hold on;plot(cells(2,closedset(1,end)),cells(3,closedset(1,end)),'r.');hold off
    end
%     if goalfound==0&&closedset(1,end)==endind
%         disp('stop');
%     end
end
if goalfound
%     disp('backtracking path')
    indpath=[];
%     csi=size(closedset,2);
%     [~,csi]=min(abs(closedset(1,:)-endind));
    csi=size(closedset,2);
    currpi=closedset(2,csi);
    if csi~=closedset(1,1)
        while currpi~=closedset(1,1)
            indpath=[currpi,indpath];
            [minval,csi]=min(abs(closedset(1,:)-currpi));
            if minval>0
                currpi=0;
            else
                currpi=closedset(2,csi);
            end
        end
    end
    indpath=[startind,indpath,closedset(1,end)];
%     indpath=[];
% %     currpi=size(closedset,2);
%     csi=size(closedset,2);
%     currpi=closedset(1,csi);
%     while currpi~=0
%         indpath=[currpi,indpath];
%         [~,csi]=min(closedset(1,:)-currpi);
%         currpi=closedset(1,csi);
%     end
% %     indpath=closedset;
%     disp('goal found')
else
    indpath=[];
%     indpath=closedset(1,:);
end
% indpath=closedset;

end

function goalfound=goalcheck(currcell,lims,goaldist,goal)
depth=currcell(1);
steps=[1,1,-1,-1;
    1,-1,-1,1];
xdiff=(lims(1,2)-lims(1,1))/(2^depth);
ydiff=(lims(2,2)-lims(2,1))/(2^depth);
bb=steps.*[xdiff;ydiff];
currbb=bb+currcell(2:3);
maxdepth=inf;
if bbcheck(currbb,goal,depth,maxdepth,goaldist)==0
    goalfound=false;
else
    goalfound=true;
end
end

function [currnode,openset]=pop(openset)
[~,osind]=min(openset(3,:)+openset(4,:));
currnode=openset(:,osind);
if size(openset,2)>1
    openset=[openset(:,1:osind-1),openset(:,osind+1:end)];
else
    openset=[];
end
end

function openset=appendos(openset,cnbind,currnode,cells,goalloc)
nodecost=nodecostcalc(cnbind,currnode,cells);
if isempty(openset)
    openset=[cnbind;currnode(1);nodecost+currnode(3);norm(goalloc-cells(2:3,cnbind))];
else
    if min(abs(openset(1,:)-cnbind))~=0
        openset=[openset,[cnbind;currnode(1);nodecost+currnode(3);norm(goalloc-cells(2:3,cnbind))]];
    else
        [~,osind]=min(abs(openset(1,:)-cnbind));
%         if cnbind==145
%             disp(['parent index:',num2str(openset(2,osind))])
%             disp(['old cost:',num2str(openset(3,osind))])
%             disp(['new parent index:',num2str(currnode(1))])
%             disp(['new cost:',num2str(nodecost)])
%             
%         end
        if openset(3,osind)>nodecost+currnode(3)
            openset(:,osind)=[cnbind;currnode(1);nodecost+currnode(3);norm(goalloc-cells(2:3,cnbind))];
        end
    end
end
end

function nodecost=nodecostcalc(cnbind,currnode,cells)
distcost=norm(cells(2:3,cnbind)-cells(2:3,currnode(1)));
levelcost=50*cells(1,cnbind);
nodecost=distcost+levelcost;
end