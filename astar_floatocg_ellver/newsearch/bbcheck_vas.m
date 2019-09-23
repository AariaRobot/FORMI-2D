function status=bbcheck_vas(bb,obstacles,rad)%depth,maxdepth)
% bounding box check for vanilla a*

bbxl=min(bb(1,:));bbxr=max(bb(1,:));bbyb=min(bb(2,:));bbyt=max(bb(2,:));
inx_thin = bbxl<obstacles(1,:)&bbxr>obstacles(1,:);
inx_thick = bbxl-rad<obstacles(1,:)&bbxr+rad>obstacles(1,:);
iny_thin = bbyb<obstacles(2,:)&bbyt>obstacles(2,:);
iny_thick = bbyb-rad<obstacles(2,:)&bbyt+rad>obstacles(2,:);
certins = (inx_thin&iny_thick) | (inx_thick&iny_thin);
nearcorners=false(size(certins));
for ii=1:size(bb,2)
    nearcorners = nearcorners | sqrt(sum((bb(:,ii)-obstacles).^2))<rad;
end
inlist=certins|nearcorners;

% inlist=inpolygon(obstacles(1,:),obstacles(2,:),bb(1,:),bb(2,:));
if sum(inlist)>0
    status=1;
%     if depth<maxdepth
%         status=-1;
%     else
%         status=1;
%     end
else
    status=0;
end