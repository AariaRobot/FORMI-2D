function [newpath,newqvals]=partialinterp(origpath,collvec,smoothmult,qvals)
% qvals=query values for interpolating prevpath from origpath
% collvec=occupancyvector;
% prevpath=currpath;
% collision vector for prevpath
ppcv = max(reshape(collvec,smoothmult,[]));
newqvals=qvals;
nqi=1;
for ii=1:length(qvals)-1
    if max(ppcv(ii:ii+1))
        newqvals = [newqvals(1:nqi),(newqvals(nqi)+newqvals(nqi+1))/2,newqvals(nqi+1:end)];
        nqi=nqi+1;
    end
    nqi=nqi+1;
end

% opl = size(origpath,2);
% % % t-values used for the original path
% tvals = linspace(1,opl,opl);
% same t-values as in splinesmoothing_fixedoris
tvals=[0,cumsum(sqrt(sum(diff(origpath,1,2).^2)))];
if qvals(1)==1
    newqvals=(newqvals-1).*max(tvals)/(max(newqvals)-1);
else
    newqvals=(newqvals).*max(tvals)/(max(newqvals));
end
% interp1 returned NaN without this:
newqvals(end)=tvals(end);

ipx=interp1(tvals,origpath(1,:),newqvals);
ipy=interp1(tvals,origpath(2,:),newqvals);
newpath=[ipx;ipy];