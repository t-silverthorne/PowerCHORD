function Q = getQuadForm(tt,freqs)
%GETQUADFORM Summary of this function goes here
%   Detailed explanation goes here
H     = [0 1 0; 0 0 1];
X     = [ones(n,1) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
Q     = pagemldivide(pagemtimes(pagetranspose(X),X),pagetranspose(X));
Q     = pagemtimes(H,Q);
Q     = pagemtimes(pagetranspose(Q),Q);
Q     = mean(Q,3);
end

