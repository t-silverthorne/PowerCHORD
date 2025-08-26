clear
n     = 48;
L     = randn(n,n);
L     = L*L';
Sigma = randn(n,n)/n;
Sigma = Sigma*Sigma';
mu    = 10+randn(n,1);


[~,Tlin] = getSymm4Mask_subtypes(n);
tic;getExactMoments(L,Sigma,mu,Tlin)
toc
gL=gpuArray(L);
gSigma=gpuArray(Sigma);
gMu = gpuArray(mu);
tic;getExactMoments(gL,gSigma,gMu,Tlin)
toc