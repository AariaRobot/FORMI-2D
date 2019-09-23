function [newcells,improvedinds,newinds]=improvepathprec_withnbs(cells,indpath,obstacles,lims,maxdepth,rad)
obst=obstacles;
newcells=cells;
% maxdepth=maxdepth+1;
improvedinds=[];
% newinds contains the indices of the cells that have been added to
% newcells
newinds=[];
if indpath(end)==indpath(1)
    indpath=indpath(1);
end
for ii=1:length(indpath)
    if cells(4,indpath(ii))~=0
        [~,~,extracells] = improveprec(cells,indpath(ii),obst,lims,maxdepth,rad);
        newcells=[newcells,extracells];
        improvedinds=[improvedinds,indpath(ii)];
        addl=size(extracells,2);
        currl=size(newcells,2);
        newinds=[newinds,linspace(currl-addl+1,currl,addl)];
    end
end
% disp(['improved points: ',int2str(length(improvedinds))])
goodvals=true(1,size(newcells,2));
goodvals(improvedinds)=false;
newcells=newcells(:,goodvals);
% because all the deleted values were in the list ahead of the first added
% value, the correct new indices can be found by reducing the number of the
% deleted values from the new indices.
bvn = sum(~goodvals);
newinds=newinds-bvn;