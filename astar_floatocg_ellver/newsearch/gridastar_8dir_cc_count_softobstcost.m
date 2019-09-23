function [indpath,cc_count]=gridastar_8dir_cc_count_softobstcost(ocg,startgl,endgl,xdiff,ydiff,softcostocg)
% node contents: start grid location, parent grid location, cost from start, estimated
% cost to goal
% startgl=[30;45];endgl=[100;70];
openset=[startgl;startgl;0;distcalc_8dir(startgl,endgl,xdiff,ydiff)];
closedset=[];
goalfound=0;
% iters=0;
if ocg(startgl(1),startgl(2))||ocg(endgl(1),endgl(2))
    indpath=[];
else
    while ~isempty(openset)&&~goalfound
    %     iters=iters+1
        [currnode,openset]=pop(openset);
        closedset=[closedset,currnode];
        neighbourinds=findgridneighbours(ocg,currnode(1:2));
        for ii=1:size(neighbourinds,2)
            cnbind=neighbourinds(:,ii);
            if min(sum(abs(closedset(1:2,:)-cnbind)))~=0
                openset=appendos(openset,cnbind,currnode,endgl,xdiff,ydiff,softcostocg);
            end
        end
        if sum(abs(closedset(1:2,end)-endgl))==0
            goalfound=1;
        end
    end
    if goalfound
    %     disp('backtracking path')
        indpath=[];
    %     csi=size(closedset,2);
        [~,csi]=min(sum(abs(closedset(1:2,:)-endgl)));
        currpi=closedset(3:4,csi);
        while sum(abs(currpi-closedset(1:2,1)))~=0
            indpath=[currpi,indpath];
            [minval,csi]=min(sum(abs(closedset(1:2,:)-currpi)));
            if minval>0
                disp('failure')
                currpi=[0;0];
            else
                currpi=closedset(3:4,csi);
            end
        end
        indpath=[startgl,indpath,endgl];
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
cc_count=size(closedset,2);
if size(openset,2)>0
    lininds=sub2ind(size(ocg),openset(1,:),openset(2,:));
    cc_count=cc_count+length(unique(lininds));
end
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
% if size(openset,2)>1
%     openset=[openset(:,1:osind-1),openset(:,osind+1:end)];
% else
%     openset=[];
% end
end

function openset=appendos(openset,cnbind,currnode,endgl,xdiff,ydiff,softcostocg)
% nodecost=nodecostcalc(cnbind,currnode,cells);
% nodecost=currnode(5)+norm(diag([xdiff,ydiff])*(currnode(1:2)-cnbind));
nodecost=currnode(5)+distcalc_8dir(cnbind,currnode(1:2),xdiff,ydiff)+softcostocg(cnbind(1),cnbind(2));
if isempty(openset)
    openset=[cnbind;currnode(1:2);nodecost;distcalc_8dir(cnbind,endgl,xdiff,ydiff)];
else
    if min(sum(abs(openset(1:2,:)-cnbind)))~=0
        openset=[openset,[cnbind;currnode(1:2);nodecost;distcalc_8dir(cnbind,endgl,xdiff,ydiff)]];
    else
        [~,osind]=min(sum(abs(openset(1:2,:)-cnbind)));
%         if cnbind==145
%             disp(['parent index:',num2str(openset(2,osind))])
%             disp(['old cost:',num2str(openset(3,osind))])
%             disp(['new parent index:',num2str(currnode(1))])
%             disp(['new cost:',num2str(nodecost)])
%             
%         end
        if openset(5,osind)>nodecost
            openset(:,osind)=[cnbind;currnode(1:2);nodecost;distcalc_8dir(cnbind,endgl,xdiff,ydiff)];
        end
    end
end
end

function dist=distcalc_8dir(cnbind,endgl,xdiff,ydiff)
diff=abs(cnbind-endgl);
[mind,mindind]=min(diff);
if mindind==1
    multval=ydiff;
else
    multval=xdiff;
end
dist=mind*(xdiff+ydiff)/sqrt(2)+(max(diff)-mind)*multval;
end

function nodecost=nodecostcalc(cnbind,currnode,cells)
distcost=norm(cells(2:3,cnbind)-cells(2:3,currnode(1)));
levelcost=0.1*cells(1,cnbind).^2;%0;%50*cells(1,cnbind);%
nodecost=distcost+levelcost;
end

function neighbourinds=findgridneighbours(ocg,nodeinds)
nbmat=[-1,0,1,0;0,-1,0,1];
neighbourinds=nodeinds+nbmat;
validnbis=true(1,size(neighbourinds,2));
ocgs=size(ocg);
for ii=1:size(neighbourinds,2)
    testloc=neighbourinds(:,ii);
    if testloc(1)>ocgs(1)||testloc(2)>ocgs(2)||min(testloc)<1
        validnbis(ii)=false;
    elseif ocg(testloc(1),testloc(2))
        validnbis(ii)=false;
    end
end
neighbourinds = neighbourinds(:,validnbis);

extranbs=[-1,-1,1,1;-1,1,-1,1];
extranbis = nodeinds + extranbs;
validenbis = true(1,size(extranbis,2));
for jj=1:size(extranbis,2)
    testloc=extranbis(:,jj);
    if testloc(1)>ocgs(1)||testloc(2)>ocgs(2)||min(testloc)<1
        validenbis(jj)=false;
    elseif ocg(testloc(1),testloc(2))
        validenbis(jj)=false;
    elseif (ocg(nodeinds(1),testloc(2))+ocg(testloc(1),nodeinds(2)))==2
        validenbis(jj)=false;
    end
end
neighbourinds = [neighbourinds,extranbis(:,validenbis)];
end