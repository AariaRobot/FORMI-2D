function mrg=mapobsttomrg(obstacles,mrg,platloc,platori,mindist)

rotmat=[platori(1),platori(2);-platori(2),platori(1)];
obstacles=rotmat*(obstacles-platloc);
obsdists=sum(obstacles.^2);
[vals,inds]=sort(obsdists);
% finding the relevant obstacles:
relo=[];
reldist=(1.5+mindist)^2;
for ii=1:length(inds)
    if vals(ii)>reldist
        break;
    else
        relo=[relo,obstacles(:,inds(ii))];
    end
end
th1vec=linspace(-pi*0.9,pi*0.9,size(mrg,1));
th2vec=linspace(-pi*0.9,pi*0.9,size(mrg,2));
n=length(th1vec);
m=length(th2vec);
fullmat=zeros(2,n*m);
for ii=1:n
    fullmat(:,(ii-1)*m+1:ii*m)=[ones(1,m)*th1vec(ii);th2vec];
end
th1vec=fullmat(1,:);th2vec=fullmat(2,:);
[eps,j1ps]=FK2Rvec(th1vec,th2vec);
distances=ones(1,size(j1ps,2))*Inf;
for ii=1:size(relo,2)
    point=relo(:,ii);
    distances1=linepointdist_vecver(j1ps,zeros(2,size(j1ps,2)),point);
    distances2=linepointdist_vecver(j1ps,eps,point);
    distances=min([distances;distances1;distances2]);
end
shortdists=sign(distances-mindist);
shortdists=sign(shortdists-0.5);
shortdists=(1-shortdists)/2;
shortdistmat=vec2mat(shortdists,m);
shortdistmat=logical(shortdistmat);
mrg(shortdistmat)=-1;