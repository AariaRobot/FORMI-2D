function plotgrid_light(ocg,discprec)
% map = robotics.BinaryOccupancyGrid(flip(ocg'),1/discprec);
map = robotics.OccupancyGrid(flip(ocg')./max(max(ocg)),1/discprec);
map.GridLocationInWorld = [1,1]*discprec/2;
% figure(2);
map.show
axis equal
