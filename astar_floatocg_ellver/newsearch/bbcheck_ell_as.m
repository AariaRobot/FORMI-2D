function status=bbcheck_ell_as(bb,obstacles,maxrads,M)
% checkes bounding boxes against ellipses for a*.

cpl=(min(bb,[],2)+max(bb,[],2))/2;
bbdiff=max(bb,[],2)-min(bb,[],2);
bbhdiam=norm(bbdiff)/2;
status=false;
for jj=1:size(bb,2)-1
    p0=bb(:,jj);
    p1=bb(:,jj+1);
    dists_squared=sum((cpl-obstacles).^2);
    relobst=dists_squared<(maxrads+bbhdiam).^2;
    allinds=1:size(obstacles,2);
    for ii=allinds(relobst)
        coll=edge_ell_int(M(:,:,ii),obstacles(:,ii),p0,p1);
        if coll
            status=true;
            break;
        end
    end
    if status
        break;
    end
end
% % bbxl=min(bb(1,:));bbxr=max(bb(1,:));bbyb=min(bb(2,:));bbyt=max(bb(2,:));
% % 
% % bbmaxr=norm([bbxr-bbxl;bbyt-bbyb]./2);
% % maxrads_sq=(maxrads+bbmaxr).^2;
% % % bbminr=min([bbxr-bbxl;bbyt-bbyb]./2);
% % % minrads_sq=(minrads+bbminr).^2;
% % bbc=[bbxr+bbxl;bbyt+bbyb]./2;
% % dists_sq=sum((bbc-obstacles).^2);
% % abovemaxrads=dists_sq>maxrads_sq;
% % % belowminrads=dists_sq<minrads_sq;
% % if min(abovemaxrads)
% % %     case where all ellipses are more than maxrad away from the bounding
% % %     box center-> no collision:
% %     status=0;
% % else
% %     status=0;
% %     cornerdists_sq=[sum(([bbxr;bbyt]-obstacles).^2);sum(([bbxr;bbyb]-obstacles).^2);sum(([bbxl;bbyb]-obstacles).^2);sum(([bbxl;bbyt]-obstacles).^2)];
% %     shortcornerdists=cornerdists_sq<ones(4,1)*maxrads.^2;
% %     posscoverells=find(sum(shortcornerdists)==4);
% %     box=[bbxr,bbyt;bbxr,bbyb;bbxl,bbyb;bbxl,bbyt];%;bbxr,bbyt];
% %     for ii=posscoverells
% %         inclvec=false(4,1);
% %         for jj=1:4
% %             point=box(jj,:)';
% %             inclvec(jj)=ispointinell_vecver(M,obstacles(:,ii),point);
% %         end
% %         if max(inclvec)
% %             status=1;
% %         end
% %         if min(inclvec)
% %             status=1;
% %             break;
% %         end
% %     end
% %     if status==0
% %         possints=find(~abovemaxrads);
% %         box=[bbxr,bbyt;bbxr,bbyb;bbxl,bbyb;bbxl,bbyt;bbxr,bbyt];
% %         for ii=possints
% %             coll=false;
% %             for jj=1:4
% %                 p0=box(jj,:)';
% %                 p1=box(jj+1,:)';
% %                 coll=edge_ell_int(M(:,:,ii),obstacles(:,ii),p0,p1);
% %                 if coll
% %                     break;
% %                 end
% %             end
% %             if coll
% %                 status=1;
% %                 break;
% %             end
% %         end
% %     end
% %     if status==0
% %         for ii=possints
% %             point=obstacles(:,ii);
% %             if point(1)>=bbxl&&point(1)<=bbxr&&point(2)>=bbyb&&point(2)<=bbyt
% %                 status=1;
% %                 break;
% %             end
% %         end
% %     end
% % end




%         
% %             p0=box(jj,:)';
% %             p1=box(jj+1,:)';
% %             edge_ell_int(m,k,p0,p1)
% end
% 
% inx_thin = bbxl<obstacles(1,:)&bbxr>obstacles(1,:);
% inx_thick = bbxl-rad<obstacles(1,:)&bbxr+rad>obstacles(1,:);
% iny_thin = bbyb<obstacles(2,:)&bbyt>obstacles(2,:);
% iny_thick = bbyb-rad<obstacles(2,:)&bbyt+rad>obstacles(2,:);
% certins = (inx_thin&iny_thick) | (inx_thick&iny_thin);
% % all corner indices:
% acis = false(size(bb,2),size(obstacles,2));
% nearcorners=false(size(certins));
% for ii=1:size(bb,2)
%     acis(ii,:) = sqrt(sum((bb(:,ii)-obstacles).^2))<rad;
%     nearcorners = nearcorners | acis(ii,:);
% end
% inlist=certins|nearcorners;
% 
% % inlist=inpolygon(obstacles(1,:),obstacles(2,:),bb(1,:),bb(2,:));
% if sum(inlist)>0
%     if depth<maxdepth
%         if max(sum(acis))==size(bb,2)
%             status=1;
%         else
%             status=-1;
%         end
%     else
%         status=1;
%     end
% else
%     status=0;
% end