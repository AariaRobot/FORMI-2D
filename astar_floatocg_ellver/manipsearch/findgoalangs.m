function goalangs=findgoalangs(currloc,currori,goal)
% currori=-currori;
% rotmat=[currori(1),-currori(2);currori(2),currori(1)];
rotmat=[currori(1),currori(2);-currori(2),currori(1)];
goal=rotmat*(goal-currloc);
[~,goalax,goalay]=full_IK_2R(goal(1),goal(2));
goalangs=[goalax,goalay];
