function neighbours=findallneighbours(cells,lims)
neighbours={};
for ii=1:size(cells,2)
    neighbours{ii}=findcellneighbours(cells,ii,lims(1,:),lims(2,:));
end