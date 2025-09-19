function [Q2,Qinf] = getQuadForm(tt,freqs)
%GETQUADFORM Computes the quadratic form of input data
%   This function takes time vector 'tt' and frequency vector 'freqs',
%   constructs a design matrix, and calculates the quadratic forms Q2 (mean 
%   across frequencies) and Qinf (for each frequency).
H     = [0 1 0; 0 0 1];
n     = length(tt);
X     = [ones(n,1,length(freqs)) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
Q     = pagemldivide(pagemtimes(pagetranspose(X),X),pagetranspose(X));
Q     = pagemtimes(H,Q);
Qinf  = pagemtimes(pagetranspose(Q),Q);
Q2    = mean(Qinf,3);
end
