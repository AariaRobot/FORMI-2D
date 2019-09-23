function cellind=findcellind(cells,target)
[~,cellinds]=sort(sum((cells(2:3,:)-target).^2));
for ii=1:length(cellinds)
    cellind=cellinds(ii);
    status=cells(4,cellind);
    if status~=-1
        break;
    end
end