function cellind=findcellind_2(cells,target,lims)
cellind=0;
[~,cellinds]=sort(sum((cells(2:3,:)-target).^2));
obox=[[1,1,-1,-1]*(lims(1,2)-lims(1,1));[1,-1,-1,1]*(lims(2,2)-lims(2,1))]./2;
for ii=1:length(cellinds)
    currcell=cells(:,cellinds(ii));
    currbox=obox*2^(1-currcell(1))+currcell(2:3);
    if inpolygon(target(1),target(2),currbox(1,:),currbox(2,:))
        cellind = cellinds(ii);
        break;
    end
end