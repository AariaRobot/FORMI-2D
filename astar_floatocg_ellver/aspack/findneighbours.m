function [neighbours,dists]=findneighbours(loc,map)
neighbours=zeros(2,8);
dists=zeros(1,8);
nbnum=0;
for jj=1:2
    for ii=[-1,1]
        tloc=loc;
        tloc(jj)=tloc(jj)+ii;
        if min(tloc)>0&&tloc(1)<=size(map,1)&&tloc(2)<=size(map,2)
            if ~map(tloc(1),tloc(2))
                nbnum=nbnum+1;
                neighbours(:,nbnum)=tloc;
                dists(nbnum)=1;
            end
        end
    end
end
for kk=[-1,1]
    for ii=[-1,1]
        tloc=loc+[kk;ii];
        if min(tloc)>0&&tloc(1)<=size(map,1)&&tloc(2)<=size(map,2)
            if ~map(tloc(1),tloc(2))
                nbnum=nbnum+1;
                neighbours(:,nbnum)=tloc;
                dists(nbnum)=sqrt(2);
            end
        end
    end
end
neighbours=neighbours(:,1:nbnum);
dists=dists(1:nbnum);
    