function occupancyvector=pathcc_astarver(path,ocg,lims,discprec)
% xdiff=lims(1,2)-lims(1,1);
% ydiff=lims(2,2)-lims(2,1);
% testpath=[path(1,:)./(xdiff)-lims(1,1);
%     path(2,:)./(ydiff)-lims(2,1)];
% testpath=ceil(testpath.*([size(ocg,1);size(ocg,2)]*ones(1,size(testpath,2))));
testpath=ceil(path./([discprec;discprec]*ones(1,size(path,2))));

occupancyvector=or(or(testpath(1,:)<1,testpath(1,:)>size(ocg,1)),or(testpath(2,:)<1,testpath(2,:)>size(ocg,2)));
currtestpath=testpath(:,~occupancyvector);
lininds=sub2ind(size(ocg),currtestpath(1,:),currtestpath(2,:));
% lininds=sub2ind(size(ocg),testpath(1,:),testpath(2,:));
occupancyvector(~occupancyvector)=ocg(lininds);