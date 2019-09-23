function indpath=cdastar_withnbs(cells,startind,endind,xlims,ylims,nbs,gridsizemult,gridsizepow,prefw)
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
            openset=appendos(openset,cnbind,currnode,cells,goalloc,gridsizemult,gridsizepow,prefw);
        end
    end
    if closedset(1,end)==endind
        goalfound=1;
    end
end
if goalfound
%     disp('backtracking path')
    indpath=[];
%     csi=size(closedset,2);
    [~,csi]=min(abs(closedset(1,:)-endind));
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
    indpath=[startind,indpath,endind];
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

function openset=appendos(openset,cnbind,currnode,cells,goalloc,gridsizemult,gridsizepow,prefw)
nodecost=nodecostcalc(cnbind,currnode,cells,gridsizemult,gridsizepow,prefw);
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

function nodecost=nodecostcalc(cnbind,currnode,cells,gridsizemult,gridsizepow,prefw)
distcost=norm(cells(2:3,cnbind)-cells(2:3,currnode(1)));
if cells(1,cnbind)<prefw
    levelcost=0;
else
    levelcost=gridsizemult*cells(1,cnbind)^gridsizepow;
end
nodecost=distcost+levelcost;
end