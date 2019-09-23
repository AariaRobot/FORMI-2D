function res=edge_ell_int(m,k,p0,p1)
% m=M(:,:,1)
% k=K(:,1)
% p1=gpuArray(p1)
% p2=gpuArray(p2)
% p0=p1;
% p1=p2;

q2=(p1-p0)'*m*(p1-p0);
q1=(p1-p0)'*m*(p0-k);
q0=(p0-k)'*m*(p0-k)-1;
discr=q1^2-q0*q2;
if discr<0
    res=false;
else
    dc=sqrt(discr);
    r1=(-q1-dc)/q2;
    r2=(-q1+dc)/q2;
    minr=min(r1,r2);maxr=max(r1,r2);
    if minr<1&&maxr>0
        res=true;
    else
        res=false;
    end
end
