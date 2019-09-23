function occupancyvector=pathcc(path,ocg,lims,maxdepth)
maxdepth=log(size(ocg,1))/log(2)+1;
testpath=[path(1,:)./(lims(1,2)-lims(1,1))-lims(1,1);
    path(2,:)./(lims(2,2)-lims(2,1))-lims(2,1)];
testpath=ceil(testpath.*2^(maxdepth-1));

occupancyvector=or(or(testpath(1,:)<1,testpath(1,:)>size(ocg,1)),or(testpath(2,:)<1,testpath(2,:)>size(ocg,2)));
currtestpath=testpath(:,~occupancyvector);
lininds=sub2ind(size(ocg),currtestpath(1,:),currtestpath(2,:));
% lininds=sub2ind(size(ocg),testpath(1,:),testpath(2,:));
occupancyvector(~occupancyvector)=ocg(lininds);