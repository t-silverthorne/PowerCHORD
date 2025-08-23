rng('default')
addpath('../perm_test_utils/')
n     = 20;
Amp   = 100;
tt    = rand(n,1);
acro  = 2*pi*rand;
alpha = .05;
freqs = [1];
Nsamp = 1e3;
ftrue = 1;
freqs = reshape(freqs,1,1,[]);
[~,L] = getSpecPaged(tt,freqs);
J     = ones(n,n)-eye(n);
w1    = factorial(n-1)/factorial(n);
w2    = factorial(n-2)/factorial(n);
y     = Amp*cos(2*pi*ftrue*tt-acro) + randn(n,Nsamp);

1-mean((w1*trace(L)*diag(y'*y) + w2*trace(L*J)*diag(y'*J*y))./diag(y'*L*y))/alpha


Nperm = 1e3;
power_mc = mean(getPermPval(tt,y,freqs,Nperm,'T2')<alpha)
%%
A = w1*trace(L)*eye(n) + w2*trace(L*J)*J;
B = L;
1-eig(A,B)