s1l=128;
s2l=64;
sls=[s1l;s2l];
mrg=zeros(s1l,s2l);
startangs=[-1;1/3]*pi*3/4;
effortmults=[10;1];
startangs=(startangs+0.9*pi).*sls/(1.8*pi);
cartgoal=[-0.8,1];
% cartgoal=cartgoal*1000;
[~, ws_th1v, ws_th2v] = full_IK_2R (cartgoal(1),cartgoal(2));
ea1=[ws_th1v(1);ws_th2v(1)];
ea2=[ws_th1v(2);ws_th2v(2)];
ea1=(ea1+0.9*pi).*sls/(1.8*pi);
ea2=(ea2+0.9*pi).*sls/(1.8*pi);
endangs=ea1;
obstacles=[0.76;0.8]*1;
platloc=[0;0];platori=[1;0];
mrg=mapobsttomrg(obstacles,mrg,platloc,platori);
mrg(:,sls(2)/2:sls(2)/2+1)=ones(sls(1),2)*-1;