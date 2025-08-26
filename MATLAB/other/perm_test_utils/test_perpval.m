Nf    = 10;
n     = 20;
freqs = rand(1,1,Nf)*10;
tt    = rand(n,1);
y     = randn(n,1e4);
tic
pvals = getPermPval(tt,y,freqs,1e3,'Tinf');
toc

histogram(pvals,30)