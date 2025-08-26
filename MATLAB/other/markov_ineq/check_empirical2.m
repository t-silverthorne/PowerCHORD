clear
%rng('default')
n     = 100;
Amp   = 100;
tt    = linspace(0,1,n+1);
tt    = tt(1:end-1)';
tt    = rand(n,1);
acro  = pi/2;
alpha = .15;
freqs = linspace(1,n/2,2);
Nsamp = 1e3;
ftrue = 1;
freqs = reshape(freqs,1,1,[]);
[~,L] = getSpecPaged(tt,freqs);
J     = ones(n,n)-eye(n);
w1    = factorial(n-1)/factorial(n);
w2    = factorial(n-2)/factorial(n);
y     = Amp*cos(2*pi*ftrue*tt-acro) + randn(n,Nsamp);

yy   = sum(y.*y,1);
yJy  = sum(y.*(J*y),1);
yLy  = sum(y.*(L*y),1);
pbnd = (w1*trace(L)*yy + w2*trace(L*J)*yJy)./yLy;
mean(pbnd)
%%
mean(pbnd<alpha)
mean(getPermPval(tt,y,freqs,1e3,'T2')<alpha)