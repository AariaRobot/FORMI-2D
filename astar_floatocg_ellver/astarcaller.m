function [locpath,ocg,runtime,cc_count]=astarcaller(obst, discprec, rad, lims, start, goal, fignums, astarver, obstcost, ocp, xws, yws, angs, maxrads, M, sigmas)
%% make the map:
tic;
switch astarver
    case 1
%         ocg = makeocg_precver(obst, discprec, rad, lims);
        ocg = makeocg_precver_ells(obst, discprec, lims, maxrads, M);
    case 2
%         ocg = makeocg(obst, discprec, rad, lims);
        ocg = makeocg_from_ellipses(xws,yws,angs,obst,lims,discprec);
        highinds = ocg>1;
        ocg(highinds)=1;
        ocg(~highinds)=0;
    case 3
        ocg = makeocg_floatver(obst, discprec, rad, lims);
    case 4
        ocg = makeocg_from_ellipses(xws,yws,angs,obst,lims,discprec);
    case 5
        ocg = ocgcollprobeval(obst,sigmas,lims,discprec)';
%         ocg = ocgcollprobeval_precver(obst,sigmas,lims,discprec)';%used for the 'maze' map... but it didn't help.
    case 6
        ocg = makeocg_precver_ells(obst, discprec, lims, maxrads, M);
    case 7
        ocg = makeocg_precver_ells(obst, discprec, lims, maxrads, M);
        softcostocg = makesmoothobstcosts(ocg,ocp./discprec,obstcost);
end
%% find the path:
startgl = round(start./discprec);
endgl = round(goal./discprec);
% indpath=gridastar_8dir(ocg,startgl,endgl,discprec,discprec);
if astarver>2&&astarver<5
    indpath = gridastar_floatver(ocg,startgl,endgl,discprec,discprec,obstcost,ocp);
elseif astarver<3
    indpath=gridastar(ocg,startgl,endgl,discprec,discprec);
elseif astarver==5
    [indpath,cc_count]=collprobgridsearch_8dir(ocg,startgl,endgl);
elseif astarver==6
    [indpath,cc_count]=gridastar_8dir_cc_count(ocg,startgl,endgl,discprec,discprec);
elseif astarver==7
    [indpath,cc_count]=gridastar_8dir_cc_count_softobstcost(ocg,startgl,endgl,discprec,discprec,softcostocg);
end
if astarver>4
    locpath=indpath.*[discprec;discprec];
else
    cc_count=[];
    locpath=indpath.*[discprec;discprec];
end
runtime=toc;
%% plot the results:
figure(fignums(1));clf;
plotgrid_light(ocg,discprec);
% locpath=(indpath-0.5).*([discprec;discprec]*ones(1,size(indpath,2)));
% lp2=(newpath-0.5).*([discprec;discprec]*ones(1,size(newpath,2)));
hold on;
if ~isempty(indpath)
    plot(locpath(1,:),locpath(2,:),'b');
end
% figure(fignums(2));clf;
if astarver~=3%astarver==4
    [x,y]=findelledges(xws,yws,angs,obst);
else
    [x,y]=findobstedges(obst,rad);
end
plot(x+discprec/2,y+discprec/2,'r');hold off
% plot(x,y,'r');hold on;
% hold off
% plot(locpath(1,:),locpath(2,:),'b');
axis equal
if astarver==7
    ocg=softcostocg;
end


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