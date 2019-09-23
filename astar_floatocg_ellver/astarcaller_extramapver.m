function [locpath,smoothpath,ocg,runtime,cc_count]=astarcaller_extramapver(ocg, discprec, lims, start, goal, fignums, astarver, obstcost, ocp)
cc_count=0;
%% make the map:
tic;
switch astarver
%     case 1
% %         ocg = makeocg_precver(obst, discprec, rad, lims);
%         ocg = makeocg_precver_ells(obst, discprec, lims, maxrads, M);
%     case 2
% %         ocg = makeocg(obst, discprec, rad, lims);
%         ocg = makeocg_from_ellipses(xws,yws,angs,obst,lims,discprec);
%         highinds = ocg>1;
%         ocg(highinds)=1;
%         ocg(~highinds)=0;
%     case 3
%         ocg = makeocg_floatver(obst, discprec, rad, lims);
%     case 4
%         ocg = makeocg_from_ellipses(xws,yws,angs,obst,lims,discprec);
    case 6
%         ocg=imgaussfilt(ocg,2);
        ocg=imgaussfilt(ocg,3);
        ocg=1-ocg;
        ocg=ocg-min(min(ocg));
        ocg=ocg./max(max(ocg));
%         ocg=tg>0.8*max(max(tg));
end
%% find the path:
startgl = round(start./discprec);
endgl = round(goal./discprec);
% indpath=gridastar_8dir(ocg,startgl,endgl,discprec,discprec);
if astarver>2&&astarver~=5
%     indpath = gridastar_floatver(ocg,startgl,endgl,discprec,discprec,obstcost,ocp);
    [indpath,cc_count] = collprobgridsearch_8dir(ocg,startgl,endgl);
elseif astarver==5
    [indpath,cc_count] = gridastar_8dir_cc_count(~ocg,startgl,endgl,discprec,discprec);
else
    indpath=gridastar(ocg,startgl,endgl,discprec,discprec);
end
%% smooth the path:
% if ~isempty(indpath)&&astarver<3
%     newpath = psroute(indpath,ocg);
% else
    newpath=[];
% end
%% spline-smoothing the path:
if ~isempty(indpath)&&astarver==1
%     lp2=(newpath-0.5).*([discprec;discprec]*ones(1,size(newpath,2)));
%     lp2=(newpath).*([discprec;discprec]*ones(1,size(newpath,2)));
%     locpath=(indpath-0.5).*([discprec;discprec]*ones(1,size(indpath,2)));
    lp2=(newpath).*([discprec;discprec]*ones(1,size(newpath,2)));
    locpath=(indpath).*([discprec;discprec]*ones(1,size(indpath,2)));
%     smoothpath=pathsmoother_astarver(locpath,ocg,lims,1/8,100,discprec);
%     smoothpath=pathsmoother_ellver(lp2-discprec,lims,1,100,discprec,M,obst);
    smoothpath=pathsmoother_ellver(lp2,lims,1,100,discprec,M,obst);
elseif ~isempty(indpath)&&astarver==2
    lp2=(newpath-0.5).*([discprec;discprec]*ones(1,size(newpath,2)));
    locpath=(indpath-0.5).*([discprec;discprec]*ones(1,size(indpath,2)));
%     smoothpath=pathsmoother_astarver(locpath,ocg,lims,1/8,100,discprec);
    smoothpath=pathsmoother_ellver(locpath-discprec,lims,1/8,100,discprec,M,obst);
elseif ~isempty(indpath)&&astarver==4
    locpath=(indpath).*([discprec;discprec]*ones(1,size(indpath,2)));
%     locpath=(indpath+0.5).*([discprec;discprec]*ones(1,size(indpath,2)));
%     locpath=(indpath).*([discprec;discprec]*ones(1,size(indpath,2)));
%     smoothpath=pathsmoother_astarver(locpath,ocg,lims,1/8,100,discprec);
%     smoothpath=pathsmoother_ellver(locpath-discprec,lims,1/8,100,discprec,M,obst);
    smoothpath=pathsmoother_ellver(locpath,lims,1/8,100,discprec,M,obst);
elseif ~isempty(indpath)&&astarver==5
    locpath=indpath;
%     smoothpath=pathsmoother_extramapver(locpath,ocg,lims,1/8,100);
    smoothpath=[];
elseif ~isempty(indpath)&&astarver==6
    locpath=indpath;
    socg=ocg<0.2;
%     smoothpath=pathsmoother_extramapver(locpath,socg,lims,1/8,100);
    smoothpath=[];
elseif ~isempty(indpath)
    locpath=(indpath-0.5).*([discprec;discprec]*ones(1,size(indpath,2)));
    smoothpath = [];
else
    locpath=[];
    smoothpath=[];
end
runtime=toc;
% smoothpath=pathsmoother_astarver(lp2,ocg,lims,1/8,100,discprec);
%% plot the results:
figure(fignums(1));clf;
if astarver==5
    plotgrid_light(1-ocg,discprec);
else
    plotgrid_light(ocg,discprec);
end
% locpath=(indpath-0.5).*([discprec;discprec]*ones(1,size(indpath,2)));
% lp2=(newpath-0.5).*([discprec;discprec]*ones(1,size(newpath,2)));
hold on;
if ~isempty(indpath)
    plot(locpath(1,:),locpath(2,:),'b');
    if astarver < 3
        plot(lp2(1,:),lp2(2,:),'r');
    end
end
hold off
if ~isempty(smoothpath)
    figure(fignums(2));clf;
end
if astarver<5
    if astarver~=3%astarver==4
        [x,y]=findelledges(xws,yws,angs,obst);
    else
        [x,y]=findobstedges(obst,rad);
    end
    plot(x,y,'r');hold on;
end
if ~isempty(smoothpath)
%     plot(smoothpath(1,:)-0.5*discprec,smoothpath(2,:)-0.5*discprec,'b');
    plot(smoothpath(1,:),smoothpath(2,:),'b');
end
hold off
% plot(x,y,'r');hold on;plot(smoothpath(1,:),smoothpath(2,:),'b');hold off
axis equal

if astarver<5
    figure(fignums(1));hold on;plot(x+discprec/2,y+discprec/2,'r');hold off
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