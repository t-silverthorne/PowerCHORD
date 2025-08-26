function L = getSpecQform(tt,freq)
%GETSPECQFORM quadratic form to measure spectral content at specific freq
arguments
    tt   (:,1) double;
    freq double;
end
n     = length(tt);
X     = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
H     = [0 1 0; 0 0 1];
L     = H*((X'*X)\(X'));
L     = L'*L;
end

