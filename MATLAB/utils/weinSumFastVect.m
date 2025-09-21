function ws = weinSumFastVect(Q,x)
%FASTWEINSUM Summary of this function goes here
%   Detailed explanation goes here
if ~ismatrix(Q)
    error('Input Q must be a matrix. Vectorization is wrt paged x not Q.');
end
if ndims(x) > 1 && ndims(x) < 5
    error('Input x must have 1, 5 or more dimensions.');
end

n   = size(x,1);
w   = getSymm4Weights_subtypes(n);
J   = ones(n,n)-eye(n);
hQ  = J.*Q;
X   = pagemtimes(x,pagetranspose(x));
hX  = J.*X;
dX  = eye(n).*X;
dQ  = eye(n).*Q;
uu  = ones(n,1);

pmt = @(A,B) pagemtimes(A,B);

tA  = @(M,hM)  pagetrace(pmt(J,pmt(hM,pmt(J,hM)))) + ...
    pagetrace(pmt(J,M.^2)) - ...
    2*pmt(uu',pmt(hM,pmt(hM,uu)));
tB1 = @(Q,hQ,dQ) pagetrace(pmt(J,pmt(dQ,pmt(J,hQ))));
tB2 = @(Q,hQ,dQ) pagetrace(pmt(J,pmt(hQ,hQ))) ;

tC1 = @(dQ) pmt(uu',pmt(dQ,pmt(J,pmt(dQ,uu))));
tC2 = @(Q,hQ) pagetrace(pmt(hQ,Q));

tD1 = @(Q,dQ) pagetrace(pmt(dQ,pmt(Q,J)));
tE1 = @(dQ)  pagetrace(dQ.^2);

ws = w(1)*tA(Q,hQ)*tA(X,hX)+...
    w(2)*(2*tB1(Q,hQ,dQ)*tB1(X,hX,dX)+4*tB2(Q,hQ,dQ)*tB2(X,hX,dX))+...
    w(8)*(tC1(dQ)*tC1(dX) + 2*tC2(Q,hQ)*tC2(X,hX))+...
    w(11)*(4*tD1(Q,dQ)*tD1(X,dX))+...
    w(15)*tE1(dQ)*tE1(dX);
end

