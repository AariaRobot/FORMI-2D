function pathquality = evalpath(smoothpath,dccost,travcost)
dirs=diff(smoothpath,1,2);
steplengths=sqrt(sum(dirs.^2));
oris=dirs./steplengths;
headings=atan2(oris(2,:),oris(1,:));
hdiffs=abs(diff(headings));
pathquality=sum(hdiffs)*dccost+sum(steplengths)*travcost;
