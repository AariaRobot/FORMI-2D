startgl=round(startangs);
endgl=round(ea1);
% endgl=[120;10];%no path exists to this point
ocg=mrg;
[xdiff,ydiff]=size(ocg);
% xdiff=effortmults(1)*xdiff;
% ydiff=effortmults(2)*ydiff;
indpath=gridastar(ocg,startgl,endgl,xdiff,ydiff);

ois=find(ocg(:));
[olx,oly]=ind2sub(size(ocg),ois);
% newindpath=psroute(indpath,[olx,oly]',olx,oly);
figure(2)
hold on
plot(olx,oly,'k.')
plot(indpath(1,:),indpath(2,:),'r')
% plot(newindpath(1,:),newindpath(2,:),'b')
hold off
axis equal

% origl=sum(sqrt(sum((diff(indpath,1,2).^2))));
% smoothedl=sum(sqrt(sum((diff(newindpath,1,2).^2))));