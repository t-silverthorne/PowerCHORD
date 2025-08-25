n=50;
[T,Tlin]=getSymm4Mask_subtypes(n);
Tls =sparse(Tlin);
Sigma = rand(n);
Sigma = Sigma*Sigma';
mu    = rand(n,1);
L     = rand(n);
L = L*L';
tic
getExactMoments(L,Sigma,mu,T);
toc
tic
getExactMoments(L,Sigma,mu,Tlin);
toc
tic
getExactMoments(L,Sigma,mu,Tls);
toc