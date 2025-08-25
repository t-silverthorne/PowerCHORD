clear
rng('default')
n     = 40;
Amp   = 1;
tt    = linspace(0,1,n+1);
tt    = tt(1:end-1)';
acro  = pi/2
alpha = .15;
freqs = linspace(1,1,1);
Nsamp = 1e3;
ftrue = 1;
freqs = reshape(freqs,1,1,[]);
[~,L] = getSpecPaged(tt,freqs);
J     = ones(n,n)-eye(n);
w1    = factorial(n-1)/factorial(n);
w2    = factorial(n-2)/factorial(n);
y     = Amp*cos(2*pi*ftrue*tt-acro) + randn(n,Nsamp);

pbnd = (w1*trace(L)*diag(y'*y) + w2*trace(L*J)*diag(y'*J*y))./diag(y'*L*y);
mean(pbnd<.15)
mean(getPermPval(tt,y,freqs,1e3,'T2')<.15)