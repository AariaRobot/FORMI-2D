function occupancy=testcoll(point,ocg,lims,maxdepth)
testpoint=[point(1)./(lims(1,2)-lims(1,1))-lims(1,1);
    point(2)./(lims(2,2)-lims(2,1))-lims(2,1)];
testpoint=ceil(testpoint.*2^(maxdepth-1));
occupancy=ocg(testpoint(1),testpoint(2));