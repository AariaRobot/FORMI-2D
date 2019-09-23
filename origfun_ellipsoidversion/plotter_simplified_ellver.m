function plotter_simplified_ellver(obst,locpath,cells,lims,figurenums,xws,yws,angs)
figure(figurenums(1));
plotcells(cells,lims);hold on
plot(locpath(1,:),locpath(2,:),'b');axis equal;hold off
% [x,y]=findobstedges(obst,rad);
[x,y]=findelledges(xws,yws,angs,obst);
figure(figurenums(2));
plot(x,y,'r');hold on
plot(locpath(1,:),locpath(2,:),'b');axis equal;hold off


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

function [x,y]=findelledges(xws,yws,angs,obst)
angs=-angs;
t=[0:0.01:2*pi,NaN];
[allxws,allts]=meshgrid(xws,t);
allyws=meshgrid(yws,t);
allas=meshgrid(angs,t);
allxls=meshgrid(obst(1,:),t);
allyls=meshgrid(obst(2,:),t);
aaxs = allxws.*cos(allts);
aays = allyws.*sin(allts);
rxs = aaxs.*cos(allas)+aays.*sin(allas);
rys = aays.*cos(allas)-aaxs.*sin(allas);
xgrid = rxs+allxls;
ygrid = rys+allyls;
y=ygrid(:);x=xgrid(:);