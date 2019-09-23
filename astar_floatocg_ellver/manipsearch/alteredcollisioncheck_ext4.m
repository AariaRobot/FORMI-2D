function collision=alteredcollisioncheck_ext4(loc1,loc2,obstvec,obstvecovl1,obstvecovl2)
[currlv,hl,vl]=sandv_findrelobst3(obstvecovl1,obstvecovl2,loc1,loc2);
collision=false;
if sum(currlv)==0
elseif ~hl&&~vl
    linedists=sandv_findlinedists(loc1,loc2,obstvec,currlv);
    if min(linedists)<1
        collision=true;
    end
else
    relobst=obstvec(:,currlv);
    if vl
    % %             finding obstacles right of the line:
        xdists=relobst(1,:)-loc1(1);
        if min(abs(xdists))==0
            collision=true;
        else
            rol=xdists>=0&xdists<=0.5;
            lol=xdists<=0&xdists>=-0.5;
            yhs1=relobst(2,rol);
            yhs2=relobst(2,lol);
            [yhm1,yhm2]=meshgrid(yhs1,yhs2);
            if min(min(abs(yhm1-yhm2)))==0
                collision=true;
            end
        end
    else
        ydists=relobst(2,:)-loc1(2);
        if min(abs(ydists))==0
            collision=true;
        else
            uol=ydists>=0&ydists<=0.5;
            dol=ydists<=0&ydists>=-0.5;
            xs1=relobst(1,uol);
            xs2=relobst(1,dol);
            [xm1,xm2]=meshgrid(xs1,xs2);
            if min(min(abs(xm1-xm2)))==0
                collision=true;
            end
        end
    end
end