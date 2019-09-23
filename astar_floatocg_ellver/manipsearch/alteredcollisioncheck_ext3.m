function collision=alteredcollisioncheck_ext3(loc1,loc2,obstvec,obstvecovl1,obstvecovl2)
    collision=0;
    [currlv,hl,vl]=sandv_findrelobst3(obstvecovl1,obstvecovl2,loc1,loc2);
    if hl==0&&vl==0
        linedists=sandv_findlinedists(loc1,loc2,obstvec,currlv);
        if length(linedists)~=0
            if min(linedists)<=1
                collision=1;
            else
                nearlocs=zeros(size(linedists));
                nearlocs(1:sum(currlv))=(sign((sqrt(2)-linedists(1:sum(currlv))))+1)/2;
                currlv=logical(nearlocs);
                if sum(currlv)>0
                    [~,inds]=sort(currlv,'descend');
                    relobst=obstvec(:,inds);
                    for i=1:sum(currlv)
                        op=relobst(:,i);
                        op1=[op(1)+0.5;op(2)+0.5];op2=[op(1)-0.5;op(2)+0.5];
                        op3=[op(1)+0.5;op(2)-0.5];op4=[op(1)-0.5;op(2)-0.5];
                        locvec1=[loc1,loc2];locvec2=[op1,op2];
                        collision=findlineintersections_tsver(locvec1,locvec2);
                        if collision
        %                     collision=1;
                            break;
                        end
                        locvec1=[loc1,loc2];locvec2=[op2,op4];
                        collision=findlineintersections_tsver(locvec1,locvec2);
                        if collision
        %                     collision=1;
                            break;
                        end
                        locvec1=[loc1,loc2];locvec2=[op4,op3];
                        collision=findlineintersections_tsver(locvec1,locvec2);
                        if collision
        %                     collision=1;
                            break;
                        end
                        locvec1=[loc1,loc2];locvec2=[op3,op1];
                        collision=findlineintersections_tsver(locvec1,locvec2);
                        if collision
        %                     collision=1;
                            break;
                        end

                    end
                end
            end
        end
    else
        relobst=obstvec(:,currlv);
        if vl
% %             finding obstacles right of the line:
            xdists=relobst(1,:)-loc1(1);
            if min(abs(xdists))==0
                collision=1;
            else
                rol=xdists>=0&xdists<=0.5;
                lol=xdists<=0&xdists>=-0.5;
                yhs1=relobst(2,rol);
                yhs2=relobst(2,lol);
                [yhm1,yhm2]=meshgrid(yhs1,yhs2);
                if min(min(abs(yhm1-yhm2)))==0
                    collision=1;
                end
            end
        else
            ydists=relobst(2,:)-loc1(2);
            if min(abs(ydists))==0
                collision=1;
            else
                uol=ydists>=0&ydists<=0.5;
                dol=ydists<=0&ydists>=-0.5;
                xs1=relobst(1,uol);
                xs2=relobst(1,dol);
                [xm1,xm2]=meshgrid(xs1,xs2);
                if min(min(abs(xm1-xm2)))==0
                    collision=1;
                end
            end
        end
%         if collision==0&&hl
%             disp('stop')
%         end
    end
end