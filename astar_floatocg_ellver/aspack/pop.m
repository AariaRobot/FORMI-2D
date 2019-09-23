function [newnode,opengroup]=pop(opengroup)
keys=opengroup(2,:)+opengroup(4,:);
[minkey,nnind]=min(keys);
allkeyinds=find(keys-minkey<1e-3);
if length(allkeyinds)>1
    gds=opengroup(4,allkeyinds);
    [~,bestind_ind]=min(gds);
    nnind=allkeyinds(bestind_ind);
end
% [x,y]=ind2sub([544,539],opengroup(1,nnind));
newnode=opengroup(:,nnind);
if nnind<size(opengroup,2)
    opengroup=[opengroup(:,1:nnind-1),opengroup(:,nnind+1:end)];
else
    opengroup=opengroup(:,1:end-1);
end