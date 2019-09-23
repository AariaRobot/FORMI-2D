function indsneartarget=findindsneartarget(goal,cells,maxdist,lims,nbs)
% maxdist=manipsm*1.5
origcellbox=[-1,-1,1,1;-1,1,1,-1];
goalind=findcellind_2(cells,goal,lims);
currnbs=nbs{goalind};
xdiff=lims(1,2)-lims(1,1);
ydiff=lims(2,2)-lims(2,1);
cellbox=origcellbox.*[xdiff;ydiff];
checkedinds=goalind;
indsneartarget=[];
while ~isempty(currnbs)
    currnb=currnbs(end);
    checkedinds=[checkedinds,currnb];
    currnbs=currnbs(1:end-1);
    currcell=cells(:,currnb);
    currcellbox=cellbox./2^currcell(1)+currcell(2:3);
%     current maxdist
    cmd=maxdist+norm(currcellbox(:,1)-currcell(2:3));
    currcellbox=currcellbox+origcellbox.*maxdist;
    if inpolygon(goal(1),goal(2),currcellbox(1,:),currcellbox(2,:))&&norm(goal-currcell(2:3))<cmd
        if isempty(indsneartarget)
            indsneartarget=currnb;
        elseif ~max(currnb==indsneartarget)
            indsneartarget=[indsneartarget,currnb];
        end
        extranbs=nbs{currnb};
        for ii=1:length(extranbs)
            if ~max(checkedinds==extranbs(ii))
                currnbs(end+1)=extranbs(ii);
            end
        end
    end
end
    
    