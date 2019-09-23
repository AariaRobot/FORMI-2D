function occupancygrid=ocggen(cells,lims)
maxd=max(cells(1,:));
ds=cells(1,:);% the depth values
rsx=cells(2,:)./(lims(1,2)-lims(1,1));% x-values rescaled between 0 and 1
rsy=cells(3,:)./(lims(2,2)-lims(2,1));% same for y-values
% rescaled x-values for the left side:
rslxvs=rsx-1./2.^ds;
% right side:
rsrxvs=rsx+1./2.^ds;
% y-values for bottom side:
rsbyvs=rsy-1./2.^ds;
% top side:
rstyvs=rsy+1./2.^ds;

% integer values for x:
ixvs=[rsrxvs;rslxvs]*2^(maxd-1);
% same for y:
iyvs=[rstyvs;rsbyvs]*2^(maxd-1);

% occupied cells:
ocs=logical(cells(4,:));

% occupancy grid:
ocg=false(2^(maxd-1));

% relevant (occupied) integer x-values:
rx=ixvs(:,ocs);
% relevant y-values
ry=iyvs(:,ocs);

% filling the matrix:
for ii=1:size(rx,2)
    ocg(rx(2,ii)+1:rx(1,ii),ry(2,ii)+1:ry(1,ii))=true;
end
occupancygrid=ocg;