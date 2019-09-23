function [currlv,hl,vl]=sandv_findrelobst3(x,y,loc1,loc2) %(obstvec,loc1,loc2,ovl)
%     relinds=false(size(obstvec,2),1);
%     relinds(1:ovl)=true;
    ymin=min(loc1(2),loc2(2));
    ymax=max(loc1(2),loc2(2));
    xmin=min(loc1(1),loc2(1));
    xmax=max(loc1(1),loc2(1));
    currlv = (x >= xmin-0.5) & (x <= xmax+0.5) & (y>=ymin-0.5) & (y<=ymax+0.5); 
%     nearbyobstobstvec=obstvec(:,logical(goodvals));
    
%     hl=0;vl=0;
    if loc1(1)==loc2(1)
        vl=1;
    else
        vl=0;
    end
    if loc1(2)==loc2(2)
        hl=1;
    else
        hl=0;
    end