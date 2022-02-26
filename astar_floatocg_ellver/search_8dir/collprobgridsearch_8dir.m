function [gridpath,cc_count]=collprobgridsearch_8dir(ocg,start,goal)
% grid=collprobgrid;
% start=round(astarpath(:,1)/0.02);
% goal=round(astarpath(:,end)/0.02);
% ogel=[currx,curry,parx,pary,costfromstart,estcosttogoal];
gridpath=[];
og=[start;start;0;distcalc_8dir(start,goal)];
cg=zeros(6,0);
incs=false(size(ocg));
inos=incs;inos(start(1),start(2))=true;
goalfound=false;
while ~isempty(og)&&~goalfound
    [nel,og]=pop(og);
    cg=[cg,nel];
    incs(nel(1),nel(2))=true;
    inos(nel(1),nel(2))=false;
    nbs=nel(1:2)+[[1,0,-1,0;0,1,0,-1],[1,1,-1,-1;1,-1,1,-1]];
    for ii=1:size(nbs,2)
        cnb=nbs(:,ii);
%         new neighbour is inside the grid:
        if min(cnb)>0&&cnb(1)<=size(ocg,1)&&cnb(2)<=size(ocg,2)
%             new neighbour is not in the closed set
            if ~incs(cnb(1),cnb(2))
                elcost=probmult(probmult(nel(5),ocg(cnb(1),cnb(2))),distcalc_8dir(cnb(1:2),nel(1:2)));%1-(1-nel(5))*(1-ocg(cnb(1),cnb(2)));
                goalcost=distcalc_8dir(cnb(1:2),goal);
                if inos(cnb(1),cnb(2))
                    [~,nbind]=min(sum((og(1:2,:)-cnb).^2));
                    if elcost<og(5,nbind)
                        og(:,nbind)=[cnb;nel(1:2);elcost;goalcost];
                    end
                else
                    og=[og,[cnb;nel(1:2);elcost;goalcost]];
                    inos(cnb(1),cnb(2))=true;
                end
            end
        end
    end
    if nel(1)==goal(1)&&nel(2)==goal(2)
        goalfound=true;
    end
end
if goalfound
    cel=cg(:,end);
    gridpath=[gridpath,cel(1:2)];
    while cel(5)~=0
        [~,ci]=min(sum((cg(1:2,:)-cel(3:4)).^2));
        cel=cg(:,ci);
        gridpath=[cel(1:2),gridpath];
    end
end

cc_count=size(cg,2);
if size(og,2)>0
    lininds=sub2ind(size(ocg),og(1,:),og(2,:));
    cc_count=cc_count+length(unique(lininds));
end

function [currnode,openset]=pop(openset)
% node contents: start grid location, parent grid location, cost from start, estimated
% cost to goal
[minval,osind]=min(openset(5,:)+openset(6,:));
keyinds=(openset(5,:)+openset(6,:))-minval<1e-6;
if sum(keyinds)>1
    kis=find(keyinds);
    cmc=openset(6,kis(1));
    ci=kis(1);
    kic=sum(keyinds);
    for ii=2:kic
        if openset(6,kis(ii))<cmc
            ci=kis(ii);
        end
    end
    osind=ci;
end
currnode=openset(:,osind);
openset(:,osind)=[];

function res=probmult(p1,p2)
res=p1+p2-p1*p2;%1-(1-p1)*(1-p2);
% if res<1e-10
%     res=p1+p2-p1*p2;
% end
function dist=distcalc_8dir(cnbind,endgl)
distmult=0;
diff=abs(cnbind-endgl);
mind=min(diff);
dist=mind*distmult*sqrt(2)+(max(diff)-mind)*distmult;