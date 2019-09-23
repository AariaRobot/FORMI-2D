function collprobgrid=ocgcollprobeval(mus,sigmas,lims,discprec)
xmin=lims(1,1);xmax=lims(1,2);
ymin=lims(2,1);ymax=lims(2,2);
xvec=xmin:discprec:xmax;
yvec=ymin:discprec:ymax;
[cornerx,cornery]=meshgrid(xvec,yvec);
leftx=cornerx(1:end-1,1:end-1);
boty=cornery(1:end-1,1:end-1);
rightx=cornerx(2:end,2:end);
topy=cornery(2:end,2:end);
collprobgrid=ones(size(leftx))*1e-300;
% collprobgrid=zeros(size(leftx));
for ii=1:size(mus,2)
    sigma=sigmas(:,:,ii);
    mu=mus(:,ii)';
    vals=mvncdf([leftx(:),boty(:)],[rightx(:),topy(:)],mu,sigma);
    probmat=reshape(vals,size(leftx));
    collprobgrid=collprobgrid+probmat-collprobgrid.*probmat;
end