function L = getSpecPaged(tt,freqs)
%GETSPECPAGED Summary of this function goes here
%   Detailed explanation goes here
n = length(tt);
X = [ones(n,1,length(freqs)) cos(2*pi*tt.*freqs) sin(2*pi*tt.*freqs)];
XtX = pagemtimes(pagetranspose(X),X);
L   = pagemldivide(XtX,pagetranspose(X));
L   = pagemtimes(pagetranspose(L),L);
L   = sum(L,3)/length(freqs);
J   = ones(n,n)-eye(n);
L   = L - diag(trace(L));
L   = L - trace(L*J)*J/trace(J*J);
L   = L - trace(L)*eye(n)/n;
end

