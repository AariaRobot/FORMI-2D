function smoothobst=makesmoothobstcosts(ocg,sigma,mult)
% edges?
% sigma=2;
% mult=1;
% orig_ocg=ocg;
% ocg=binocg;
edges=(0:sigma*4)+0.5;
vec=diff(normcdf(edges,0,sigma));
vec(1)=vec(1)*2;
vec=[flip(vec),vec(2:end)];
smoothobst=conv2(vec,vec',ocg,'same')*mult;
% nso=robotics.BinaryOccupancyGrid(binocg);
% so=robotics.OccupancyGrid(smoothobst);
% figure(2);so.show()