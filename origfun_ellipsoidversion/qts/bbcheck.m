function status=bbcheck(bb,obstacles,depth,maxdepth,rad)

bbxl=min(bb(1,:));bbxr=max(bb(1,:));bbyb=min(bb(2,:));bbyt=max(bb(2,:));
inx_thin = bbxl<obstacles(1,:)&bbxr>obstacles(1,:);
inx_thick = bbxl-rad<obstacles(1,:)&bbxr+rad>obstacles(1,:);
iny_thin = bbyb<obstacles(2,:)&bbyt>obstacles(2,:);
iny_thick = bbyb-rad<obstacles(2,:)&bbyt+rad>obstacles(2,:);
certins = (inx_thin&iny_thick) | (inx_thick&iny_thin);
% all corner indices:
acis = false(size(bb,2),size(obstacles,2));
nearcorners=false(size(certins));
for ii=1:size(bb,2)
    acis(ii,:) = sqrt(sum((bb(:,ii)-obstacles).^2))<rad;
    nearcorners = nearcorners | acis(ii,:);
end
inlist=certins|nearcorners;

% inlist=inpolygon(obstacles(1,:),obstacles(2,:),bb(1,:),bb(2,:));
if sum(inlist)>0
    if depth<maxdepth
        if max(sum(acis))==size(bb,2)
            status=1;
        else
            status=-1;
        end
    else
        status=1;
    end
else
    status=0;
end