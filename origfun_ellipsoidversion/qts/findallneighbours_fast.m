function neighbours=findallneighbours_fast(cells,lims,newinds,improvedinds,neighbours)
% cells are updated every loop -> the cell indices must be updated
% mapping from old cell indices to new cell indices:
cellelnum=size(cells,2);
ncis=linspace(1,cellelnum,cellelnum);
for ii=1:length(improvedinds)
    ci=improvedinds(ii);
    ncis(ci:end)=ncis(ci:end)-1;
end
% if min(ncis)==0
%     disp('risk')
% end
% neighbours={};
neighbours(improvedinds)=[];
% affectedinds=false(size(cells,2)+length(newinds),1);
affectedinds=false(length(neighbours)+length(newinds),1);
for ii=1:length(newinds)
    newnbs=findcellneighbours(cells,newinds(ii),lims(1,:),lims(2,:));
    neighbours{newinds(ii)}=newnbs;
    affectedinds(newnbs)=true;
end
unaffectedinds=~affectedinds;
unaffectedinds(newinds)=false;
affectedinds(newinds)=false;
ais=find(affectedinds);
for ii=1:sum(affectedinds)
    neighbours{ais(ii)}=findcellneighbours(cells,ais(ii),lims(1,:),lims(2,:));
end
uais=find(unaffectedinds);
for ii=1:sum(unaffectedinds)
    ois=neighbours{uais(ii)};
    nis=ncis(ois);
    if min(nis)<1
        disp('danger')
        uais(ii)
    end
%     for jj=1:length(ois)
%         ois(jj)=ncis(ois(jj));
%     end
%     if sum(abs(ois-nis))~=0
%         disp('failure')
%     end
%     neighbours{uais(ii)}=ois;
    neighbours{uais(ii)}=nis;
end
end