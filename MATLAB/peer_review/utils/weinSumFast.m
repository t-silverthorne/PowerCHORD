function ws = weinSumFast(Q,x)
%FASTWEINSUM Summary of this function goes here
%   Detailed explanation goes here
n   = length(x);
w   = getSymm4Weights_subtypes(n);
J   = ones(n,n)-eye(n);
hQ  = J.*Q;
X   = x*x';
hX  = J.*X;
dX  = diag(diag(x*x'));
dQ  = diag(diag(Q));
uu  = ones(n,1);

tA  = @(M,hM)    trace(J*hM*J*hM) + trace(J*M.^2) -2*uu'*hM*hM*uu;
tB1 = @(Q,hQ,dQ) trace(J*dQ*J*hQ);
tB2 = @(Q,hQ,dQ) trace(J*hQ*hQ) ;

tC1 = @(dQ) uu'*dQ*J*dQ*uu;
tC2 = @(Q,hQ) trace(hQ*Q);

tD1 = @(Q,dQ) trace(dQ*Q*J);
tE1 = @(dQ) trace(dQ.^2);

ws = w(1)*tA(Q,hQ)*tA(X,hX)+...
    w(2)*(2*tB1(Q,hQ,dQ)*tB1(X,hX,dX)+4*tB2(Q,hQ,dQ)*tB2(X,hX,dX))+...
    w(8)*(tC1(dQ)*tC1(dX) + 2*tC2(Q,hQ)*tC2(X,hX))+...
    w(11)*(4*tD1(Q,dQ)*tD1(X,dX))+...
    w(15)*tE1(dQ)*tE1(dX);
end

