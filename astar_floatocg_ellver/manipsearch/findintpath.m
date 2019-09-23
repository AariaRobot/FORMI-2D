function [indpath_manip,mrg]=findintpath(platloc,platori,obst,sls,goal,manipsm,sgl,rad)
%     platori=[platori(2);-platori(1)];
    mrg=zeros(sls');
    mrg=mapobsttomrg(obst./manipsm,mrg,platloc,platori,rad);
    mrg(:,sls(2)/2:sls(2)/2+1)=ones(sls(1),2)*-1;
%     figure(3);mesh(mrg)
    goalangs=findgoalangs(platloc,platori,goal./manipsm);
    indpath_manip=[];
    for jj=1:size(goalangs,1)
%         current goal angle
        cga=goalangs(jj,:)';
%         current grid location
        cgl=round((cga+0.9*pi).*sls/(1.8*pi)); 
        ocg=mrg;
        [xdiff,ydiff]=size(ocg);
        % xdiff=effortmults(1)*xdiff;
        % ydiff=effortmults(2)*ydiff;
        if min(cgl)>0&&cgl(1)<=size(ocg,1)&&cgl(2)<=size(ocg,2)
% figure(3);pls=find(ocg);[plx,ply]=ind2sub(size(ocg),pls);plot(plx,ply,'k.')
% hold on;plot(sgl(1),sgl(2),'r.');plot(cgl(1),cgl(2),'g.');hold off
            indpath_manip=gridastar(ocg,sgl,cgl,xdiff,ydiff);
            if ~isempty(indpath_manip)
                break;
            end
        end
    end