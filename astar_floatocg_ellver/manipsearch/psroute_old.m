function newroute = psroute(route,obstvec,obstvecovl1,obstvecovl2)
rl=size(route,2);
% element: ind, parent, distfromstart, heurdisttogoal
ov=[1;1;0;norm(route(:,1)-route(:,end))];
cv=[];
gf=false;
while ~gf
    [~,ci]=min(sum(ov(3:4,:)));
    ce=ov(:,ci);
    if ci==size(ov,2)
        ov=ov(:,1:end-1);
    else
        ov=[ov(:,1:ci-1),ov(:,ci+1:end)];
    end
    cv=[cv,ce];
%     cnbs=nbl{ce(1)};
%     if isempty(ce)
%         disp('stop')
%     end
    cnbs=fnbs(route,rl,ce(1),obstvec,obstvecovl1,obstvecovl2);
    for ii=1:length(cnbs)
%     append open set:
%         if ce(4)==0
%             disp('stop')
%         end
        te=[cnbs(ii);ce(1);ce(3)+norm(route(:,ce(1))-route(:,cnbs(ii)));norm(route(:,cnbs(ii))-route(:,end))];
        if min(abs(cv(1,:)-te(1)))~=0
            [ cd,cni]=min(abs(ov(1,:)-te(1)));
            if cd==0
                if te(3)<ov(3,cni)
                    ov(:,cni)=te;
                end
            else
                ov=[ov,te];
            end
        end
    end
    if norm(route(:,ce(1))-route(:,end))==0
        gf=true;
    end
end

ci=size(cv,2);
temproute=[];
while ci~=1
    temproute=[route(:,cv(1,ci)),temproute];
    [~,ci]=min(abs(cv(1,:)-cv(2,ci)));
end
temproute=[route(:,1),temproute];
newroute=temproute;
% newroute=route(:,end)*ones(1,size(route,2));
% newroute(:,1:size(temproute,2))=temproute;
% newroute=route;
end

function cnbl=fnbs(route,rl,currind,obstvec,obstvecovl1,obstvecovl2)
if currind==rl
    cnbl=[];
else
    cnbl=currind+1;
    for jj=2:rl-currind%rl-ii:-1:1%
    %         if jj==264
    %             disp('stop')
    %         end
        if ~alteredcollisioncheck_ext4(route(:,currind),route(:,currind+jj),obstvec,obstvecovl1,obstvecovl2)
            cnbl=[cnbl,currind+jj];
    %             route(:,ii+1)=route(:,ii+jj);
    %             disp([num2str(ii+1),', ',num2str(ii+jj)])
    %             break;
    %         else
    %             break;
        end
    end
end
end