function m1 = getExactPermMoment1(Q,x)
%GETPERMMOMENT1 exact first moment of T(x)=x'Qx over permutation group
n  = size(Q,1);
w1 = 1/n;
w2 = 1/n/(n-1);
J  = ones(n,n)-eye(n);

m1=w1*trace(Q)*pagemtimes(pagetranspose(x),x) +...
    w2*trace(J*Q)*pagemtimes(pagetranspose(x),pagemtimes(J,x));
end

