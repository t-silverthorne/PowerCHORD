function [Lcent,L] = getSpecPaged(tt,freqs)
%GETSPECPAGED Summary of this function goes here
%   Detailed explanation goes here
n = length(tt);
X = [ones(n,1,length(freqs)) cos(2*pi*tt.*freqs) sin(2*pi*tt.*freqs)];
XtX = pagemtimes(pagetranspose(X),X);
L   = pagemldivide(XtX,pagetranspose(X));
L   = pagemtimes(pagetranspose(L),L);
L   = sum(L,3)/length(freqs);
J   = ones(n,n)-eye(n);
Lcent = L;
%Lcent = Lcent - diag(trace(Lcent));
Lcent = Lcent - trace(Lcent*J)*J/trace(J*J);
Lcent = Lcent - trace(Lcent)*eye(n)/n;
end

