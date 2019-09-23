function [exit_flags, ws_th1v, ws_th2v, js_th1 ] = full_IK_2R (x,y)

manip.L(1) = 1;
manip.L(2) = 0.5;

ws_th1v=[];
ws_th2v=[];
js_th1=[];

give_err = 0;
exit_flags = zeros(2,1);



L1 = manip.L(1);
L2 = manip.L(2);

% x = 1;
% y = 10*0.5;

cth2 = ( ( (x^2+y^2) - L1^2 - L2^2 ) /(2*L1*L2) );
if abs(cth2)<=1
    
    sth21 = sqrt(1-cth2^2);
    sth22 = -sth21;
    
    sth2v =[sth21;
        sth22;];
    cth2v = cth2.* ones(2,1);
    
    % th21 = atan2(sth21,cth2);
    % th22 = atan2(sth22,cth2);
    
    ws_th2v =  atan2(sth2v,cth2v);
    
    % th11 = atan2(y,x) - atan2(L2*sth21 , L1+L2*cth2);
    % th12 = atan2(y,x) - atan2(L2*sth22 , L1+L2*cth2);
    
    ws_th1v =  atan2(y,x).*ones(size(sth2v)) - atan2(L2*sth2v , L1+L2*cth2v);
    exit_flags(1) = 1; % can collide with EE
    
else
    exit_flags(1) = -1;
    if give_err
        err_msg = ['out of reach input cos(th1) = ' num2str(cth2)];
        error(err_msg);
    end
end


if x^2+y^2<L1^2
js_th1 = atan2(y,x);
 exit_flags(2) = 1; % can collide with L1
else
    exit_flags(2) = -1; % no reach for L1
end

if x==0&&y==0
        exit_flags(1:2) = 2; % can collide with Base
    if give_err
        err_msg = ['x,y at base!' ];
        error(err_msg);
    end
end

end