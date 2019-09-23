function linedists=sandv_findlinedists(loc1,loc2,obstvec,currlv)
linedists = [];
sumcurrlv = sum(currlv);
if sumcurrlv ~= 0
    a=(loc2(2)-loc1(2))/(loc2(1)-loc1(1));
    c=loc1(2)-a*loc1(1);
    b=-1;
    %linedists=ones(size(obstvec,2),1)*2;
    %linedists=ones(sumcurrlv,1)*2;
    % [~,inds]=sort(currlv,'descend');
    %linedists(currlv)=abs(sum([obstvec(1,currlv).*a;obstvec(2,currlv).*b])+c*ones(1,sumcurrlv))./sqrt(a^2+b^2);
    linedists=abs(sum([obstvec(1,currlv).*a;obstvec(2,currlv).*b])+c*ones(1,sumcurrlv))./sqrt(a^2+b^2);
    % linedists=linedists(inds);
    %linedists=linedists(currlv);
end
end
% linedists=abs(sum(obstvec(:,inds).*[a;b])+c)./sqrt(a^2+b^2);
% linedists(1:sum(currlv))=abs(sum(obstvec(:,currlv).*[a;b])+c)./sqrt(a^2+b^2);
% linedists=abs(sum(obstvec.*[a;b])+c)./sqrt(a^2+b^2);