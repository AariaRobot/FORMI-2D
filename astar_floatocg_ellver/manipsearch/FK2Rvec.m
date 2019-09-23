function [P_EE_0, P_J1_0] = FK2Rvec(th1,th2)
% Vector input version of FK_2Rj without the rotation matrix
% forward kinematics of 2R manipulator with calculation of the position for
% joint 1 too.

manip.L(1) = 1;
manip.L(2) = 0.5;


L1 = manip.L(1);
L2 = manip.L(2);


% R_EE_0 = [cos(th1+th2)      -sin(th1+th2);
%     sin(th1+th2)       cos(th1+th2)];

P_EE_0 = [L1* cos(th1)+ L2 *cos(th1+th2);
    L1* sin(th1)+ L2 *sin(th1+th2)];

P_J1_0 = [L1* cos(th1);
    L1* sin(th1)];

end

