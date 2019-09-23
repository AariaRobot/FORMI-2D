function plotter_simplified(obst,rad,locpath,cells,lims,figurenums,smoothpath)
figure(figurenums(1));
plotcells(cells,lims);hold on
plot(locpath(1,:),locpath(2,:),'b');axis equal;hold off
[x,y]=findobstedges(obst,rad);
figure(figurenums(2));
plot(x,y,'r');hold on
plot(locpath(1,:),locpath(2,:),'b');axis equal;hold off
figure(figurenums(3))
plot(x,y,'r');hold on;plot(smoothpath(1,:),smoothpath(2,:),'b');hold off
axis equal


function [x,y]=findobstedges(obst,rad)
avals=0:0.01:2*pi;
svals=sin(avals)*rad;
cvals=cos(avals)*rad;
[cgrid,oxgrid]=meshgrid(cvals,obst(1,:));
fullxgrid=[cgrid+oxgrid,nan(size(cgrid,1),1)]';
[sgrid,oygrid]=meshgrid(svals,obst(2,:));
fullygrid=[sgrid+oygrid,nan(size(sgrid,1),1)]';
x=fullxgrid(:);
y=fullygrid(:);