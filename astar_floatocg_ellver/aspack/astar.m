function route=astar(map,start,goal)
startind=sub2ind(size(map),start(1),start(2));
goalind=sub2ind(size(map),goal(1),goal(2));
og=[startind;0;startind;norm(start-goal)];%loc, dfroms, parent, dtogoal
cg=[];
ocgels=false(size(map));
% cglilocs=[];

successflag=false;
ln=0;
% imshow(map');
while size(og,2)~=0%&&ln<5000
    ln=ln+1;
    [location,og]=pop(og);
    cg=[cg,location];
%     cglilocs=[cglilocs,sub2ind(size(map),location(1),location(2))];
    if location(1)==goalind
        successflag=true;
        break;
    end
    [xl,yl]=ind2sub(size(map),location(1));
%     hold on;plot(xl,yl,'r.');hold off;drawnow
    ocgels(xl,yl)=true;
    [neighbours,dists]=findneighbours([xl;yl],map);
    for ii=1:size(neighbours,2)
        % check if the location is in the closed group:
%         l1=cg(1,:)==neighbours(1,ii);
%         l2=cg(2,:)==neighbours(2,ii);
%         if max(l1(l2))
        
        liloc=sub2ind(size(map),neighbours(1,ii),neighbours(2,ii));
        if ~ocgels(neighbours(1,ii),neighbours(2,ii))
%         if ~max(cg(1,:)==liloc)
%         if min(max(abs(cg(1:2,:)-neighbours(:,ii))))
%         if ~max(min(cg(1:2,:)==neighbours(:,ii)))
            og=updateopengroup(location,neighbours(:,ii),liloc,og,goal,dists(ii));
        end
    end
%     if size(cg,2)==1
%         disp('stop')
%     end
end
ln
if successflag
    route=backtrackroute(cg,size(map));
else
    route=cg;
end