function covs=ellstocovs(xws,yws,angs,sigmafactor)
covs=zeros(2,2,length(angs));
for ii=1:length(angs)
    xw=xws(ii);yw=yws(ii);
    a=angs(ii);
    V=[cos(a),-sin(a);sin(a),cos(a)];
    S=diag([xw,yw].^2./(sigmafactor*4));
    covs(:,:,ii)=V*S/V;
end