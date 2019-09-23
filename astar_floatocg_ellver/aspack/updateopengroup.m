function opengroup=updateopengroup(location,newloc,liloc,opengroup,goal,dist)
newel=[liloc;location(2)+dist;location(1);goaldistcalc_8dir(goal,newloc)];%norm(newloc-goal)];
% check if newloc is in opengroup
elind=find((opengroup(1,:)==liloc));
if ~isempty(elind)
    if opengroup(2,elind)>newel(2)
        opengroup(:,elind)=newel;
    end
else
    opengroup=[opengroup,newel];
end

function gd=goaldistcalc_8dir(goal,newloc)
dx=abs(goal(1)-newloc(1));
dy=abs(goal(2)-newloc(2));
l=max(dx,dy);
s=min(dx,dy);
gd=sqrt(2)*s+l-s;