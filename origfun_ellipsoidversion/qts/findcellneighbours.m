function neighbourinds=findcellneighbours(cells,ind,xlims,ylims)
neighbourinds=[];
if cells(4,ind)==0
    xmax=max(xlims);ymax=max(ylims);xmin=min(xlims);ymin=min(ylims);
    % xmin=0;xmax=50;ymin=0;ymax=50;
    xdiff=(xmax-xmin);
    ydiff=(ymax-ymin);
    sx=cells(2,ind);sy=cells(3,ind);
    bbxmin=cells(2,ind)-xdiff/(2^cells(1,ind));
    bbymin=cells(3,ind)-ydiff/(2^cells(1,ind));
    bbxmax=cells(2,ind)+xdiff/(2^cells(1,ind));
    bbymax=cells(3,ind)+ydiff/(2^cells(1,ind));
    for ii=1:size(cells,2)
        if cells(4,ii)==0
            cd=cells(1,ii);
            cxdiff=xdiff/(2^cd);
            cydiff=ydiff/(2^cd);
            cx=cells(2,ii);cy=cells(3,ii);
            cxmax=cx+cxdiff;cxmin=cx-cxdiff;cymax=cy+cydiff;cymin=cy-cydiff;
            if cxmax==bbxmin
                if (cy<bbymax&&cy>bbymin)||(sy<cymax&&sy>cymin)%||cy+cydiff==bbymin||cy-cydiff==bbymax
                    neighbourinds=[neighbourinds,ii];
                end
            elseif cx-cxdiff==bbxmax
                if (cy<bbymax&&cy>bbymin)||(sy<cymax&&sy>cymin)%||cy+cydiff==bbymin||cy-cydiff==bbymax
                    neighbourinds=[neighbourinds,ii];
                end
            elseif cy+cydiff==bbymin
                if (cx<bbxmax&&cx>bbxmin)||(sx<cxmax&&sx>cxmin)%||cx+cxdiff==bbxmin||cx-cxdiff==bbxmax
                    neighbourinds=[neighbourinds,ii];
                end
            elseif cy-cydiff==bbymax
                if (cx<bbxmax&&cx>bbxmin)||(sx<cxmax&&sx>cxmin)%||cx+cxdiff==bbxmin||cx-cxdiff==bbxmax
                    neighbourinds=[neighbourinds,ii];
                end
            end
        end
    end
end
    
