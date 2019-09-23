function collprobgrid=ocgcollprobeval_precver(mus,sigmas,lims,discprec)
% discprec=discprec_astar;
% mus=obst;
% sigmas
xmin=lims(1,1);xmax=lims(1,2);
ymin=lims(2,1);ymax=lims(2,2);
xvec=xmin:discprec:xmax;
yvec=ymin:discprec:ymax;
[cornerx,cornery]=meshgrid(xvec,yvec);
leftx=cornerx(1:end-1,1:end-1);
boty=cornery(1:end-1,1:end-1);
rightx=cornerx(2:end,2:end);
topy=cornery(2:end,2:end);
collprobgrid=zeros(size(leftx));
for ii=1:size(mus,2)
    sigma=sigmas(:,:,ii);
    mu=mus(:,ii)';
%     toprvals=mvncdf([rightx(:),topy(:)],mu,sigma);
%     toplvals=mvncdf([leftx(:),topy(:)],mu,sigma);
%     botrvals=mvncdf([rightx(:),boty(:)],mu,sigma);
%     botlvals=mvncdf([leftx(:),boty(:)],mu,sigma);
%     
%     ahis=toprvals>0.5&toplvals>0.5&botrvals>0.5&botlvals>0.5;%all values are high ->the points should be projected to the other side of mu
%     toprvals(ahis)=mvncdf(2*mu-[leftx(ahis),boty(ahis)],mu,sigma);
%     toplvals(ahis)=mvncdf(2*mu-[rightx(ahis),boty(ahis)],mu,sigma);
%     botrvals(ahis)=mvncdf(2*mu-[leftx(ahis),topy(ahis)],mu,sigma);
%     botlvals(ahis)=mvncdf(2*mu-[rightx(ahis),topy(ahis)],mu,sigma);
%     
% %     ind=find(ahis,1);
% %     p=toprvals(ind)+botlvals(ind)-toplvals(ind)-botrvals(ind);
% 
%     toprmat=reshape(toprvals,size(leftx));
%     toplmat=reshape(toplvals,size(leftx));
%     botrmat=reshape(botrvals,size(leftx));
%     botlmat=reshape(botlvals,size(leftx));
% 
%     probmat=toprmat+botlmat-toplmat-botrmat;
%     collprobgrid=1-(1-collprobgrid).*(1-probmat);
    vals=zeros(size(leftx(:)));
    intfun=@(x,y)reshape(mvnpdf([x(:),y(:)],mu,sigma),size(x));
    for jj=1:length(vals)
        vals(jj)=integral2(intfun,leftx(jj),rightx(jj),boty(jj),topy(jj));
    end
%     vals=mvncdf([leftx(:),boty(:)],[rightx(:),topy(:)],mu,sigma);
    probmat=reshape(vals,size(leftx));
    collprobgrid=collprobgrid+probmat-collprobgrid.*probmat;
end

% mesh(collprobgrid)
