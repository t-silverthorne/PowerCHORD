function [Q,Qf] = getQuadForm(tt,freqs)
%GETQUADFORM Summary of this function goes here
%   Detailed explanation goes here
H     = [0 1 0; 0 0 1];
n     = length(tt);
X     = [ones(n,1,length(freqs)) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
Q     = pagemldivide(pagemtimes(pagetranspose(X),X),pagetranspose(X));
Q     = pagemtimes(H,Q);
Qf    = pagemtimes(pagetranspose(Q),Q);
Q     = mean(Qf,3);
end

