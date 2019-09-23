% save('occupancygrid','ocg')
load occupancygrid
load locpath
load cellsandlims
maxdepth=max(cells(1,:));
ccres=false(1,size(locpath,2));
testpath=[linspace(0.1,2.9,100);linspace(0.1,0.1,100)];
locpath=testpath;
occvec=pathcc(testpath,ocg,lims,maxdepth);
for ii=1:size(locpath,2)
    ccres(ii)=testcoll(locpath(:,ii),ocg,lims,maxdepth);
end