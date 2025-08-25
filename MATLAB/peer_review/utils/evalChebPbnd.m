function [pbnd,m1,m2] = evalChebPbnd(Q,x,Tq)
%EVALCHEBPBND eval Cheb-Cantelli p-value bound
m1   = getExactPermMoment1(Q,x);
m2   = getExactPermMoment2(Q,x,Tq);
Qobs = pagemtimes(pagetranspose(x),pagemtimes(Q,x));
vv   = m2 - m1.^2;
pbnd = vv./(vv+(Qobs-m1).^2);
end

