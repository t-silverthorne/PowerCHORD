addpath('../')
clear
n = 5;
L = randn(n,n);
L = L*L';
Sigma = randn(n,n)/n;
Sigma = Sigma*Sigma';
mu = 10+randn(n,1);

T = getSymm4Mask_subtypes(n);
tic
nsamp=1e5;
[m10,m11,m21,m20,m12]=getExactMoments(L,Sigma,mu,T);
[mc10,mc11,mc21,mc20,mc12]=getMonteCarloMoments(L,Sigma,mu,nsamp);
toc
fprintf('m10: %d\n',abs(m10-mc10)./mc10)
fprintf('m11: %d\n',abs(m11-mc11)./mc11)
fprintf('m21: %d\n',abs(m21-mc21)./mc21)
fprintf('m20: %d\n',abs(m20-mc20)./mc20)
fprintf('m12: %d\n',abs(m12-mc12)./mc12)
