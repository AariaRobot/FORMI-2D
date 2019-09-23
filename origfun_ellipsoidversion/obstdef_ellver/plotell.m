function plotell(currol,currxw,curryw,curra)
t=0:0.01:2*pi;
x=currxw*cos(t);%+currol(1);
y=curryw*sin(t);%+currol(2);
rx=x*cos(curra)+y*sin(curra);
ry=y*cos(curra)-x*sin(curra);
x=rx+currol(1);
y=ry+currol(2);
plot(x,y,'b')