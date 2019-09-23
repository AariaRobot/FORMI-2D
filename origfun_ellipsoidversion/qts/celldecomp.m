function cells=celldecomp(obst,maxdepth,xlims,ylims,rad)
% rad=0.005;%0.05;
celldn=maxdepth;
xmax=max(xlims);ymax=max(ylims);xmin=min(xlims);ymin=min(ylims);
% cell data: depth, center location, parent index, 4 child indices, status
% status: 1=occupied, 0=free, -1=mixed, 2=split
cells=[1;(xmax-xmin)/2+xmin;(ymax-ymin)/2+ymin;0;0;0;0;0;-1];
loopn=0;
while min(cells(9,:)+cells(8,:))<0%min(sum(cells(5:9,:),2))<0
    loopn=loopn+1;
    celln=size(cells,2);
%     currcelln=celln;
    for ii=1:celln
        if cells(9,ii)==-1&&cells(8,ii)==0
%             cells(9,ii)=2;
%         if sum(cells(5:9,ii))==-1
            depth=cells(1,ii);
            xdiff=(xmax-xmin)/(2^depth);
            ydiff=(ymax-ymin)/(2^depth);
            ploc=[cells(2,ii);cells(3,ii)];
%             bb=ploc+[-1,1,1,-1,-1;-1,-1,1,1,-1].*[xdiff;ydiff];
            bb=[-1,1,1,-1,-1;-1,-1,1,1,-1].*[xdiff;ydiff];
            for xx=1:2
                for yy=1:2
                    xchange=(xx-1.5)*xdiff;
                    ychange=(yy-1.5)*ydiff;
                    currbb=bb./2+[xchange;ychange]+ploc;
                    status=bbcheck(currbb,obst,depth,celldn,rad);
                    cells(:,end+1)=[depth+1;cells(2,ii)+xchange;cells(3,ii)+ychange;ii;0;0;0;0;status];
%                     saving the child index to the parent:
                    cells(5+2*xx+yy-3,ii)=size(cells,2);
                end
            end
        end
    end
end
changeflag=1;
while changeflag
    changeflag=0;
    % Changing parent indices to occupied if all the children are occupied:
    for ii=1:size(cells,2)
        cinds=cells(5:8,ii);
        if sum(cinds)~=0
            if sum(cells(9,cinds))==4
                cells(9,ii)=1;
                changeflag=1;
                cells(9,cinds)=-ones(1,4);
            end
        end
    end
end
% removing extra cells from the list
origcells=cells;
goodvals=true(1,size(cells,2));
for ii=1:size(origcells,2)
% %     if ii>size(origcells,2)
% %         break;
% %     end
    if origcells(9,ii)==-1%||2
        goodvals(ii)=false;
%         if ii==size(cells,2)
%             cells=cells(:,1:end-1);
%         else
%             cells=[cells(:,1:ii-1),cells(:,ii+1:end)];
%         end
    end
end
cells=origcells(:,goodvals);
newcells=[cells(1:3,:);cells(9,:)];
cells=newcells;
