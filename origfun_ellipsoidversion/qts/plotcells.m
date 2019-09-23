function plotcells(cells,lims)
% lims(1,1)=xmin,lims(1,2)=xmax,lims(2,1)=ymin,lims(2,2)=ymax
% xmax=angdnum;ymax=angdnum;
% xmin=1;ymin=1;
xmax=lims(1,2);ymax=lims(2,2);
xmin=lims(1,1);ymin=lims(2,1);
rbbx=[];bbbx=[];rbby=[];bbby=[];
hold on
for ii=1:size(cells,2)
    depth=cells(1,ii);
    xdiff=(xmax-xmin)/(2^depth);
    ydiff=(ymax-ymin)/(2^depth);
    ploc=[cells(2,ii);cells(3,ii)];
%     bb=[ploc+[-xdiff/2;-ydiff/2],ploc+[xdiff/2;-ydiff/2],ploc+[xdiff/2;ydiff/2],ploc+[-xdiff/2;ydiff/2],ploc+[-xdiff/2;-ydiff/2]];
    bb=ploc+[-1,1,1,-1,-1;-1,-1,1,1,-1].*[xdiff;ydiff];
    if cells(4,ii)==1
        rectangle('Position',[bb(1,1),bb(2,2),xdiff*2,ydiff*2],'FaceColor',[0,0,0])%[1,0,0])
        rbbx=[rbbx,bb(1,:),NaN];
        rbby=[rbby,bb(2,:),NaN];
%         plot(bb(1,:),bb(2,:),'r')
    elseif cells(4,ii)==0
        rectangle('Position',[bb(1,1),bb(2,2),xdiff*2,ydiff*2],'FaceColor',[1,1,1])%[0,0,1])
%         plot(bb(1,:),bb(2,:),'b')
        bbbx=[bbbx,bb(1,:),NaN];
        bbby=[bbby,bb(2,:),NaN];
    elseif cells(4,ii)==-1
        rectangle('Position',[bb(1,1),bb(2,2),xdiff*2,ydiff*2],'FaceColor',[1,1,1]*0.5)%[0,0,1])
    end
end
% figure(1)
% clf
% plot(obst(1,:),obst(2,:),'k.')
% hold on
% plot(bbbx,bbby,'b')
% % hold on
% plot(rbbx,rbby,'r--')
hold off
axis equal