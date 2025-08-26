clear;
addpath('../two_moment_method/')
n   = 20;
x   = randn(n,1,1,1,100,8,8);
Q   = randn(n,n);
Q   = Q*Q';
Nperm = 2e3;
tic
res = squeeze(fastMCT2pval(Q,x,Nperm,.05));
toc

[~,Tq] = getSymm4Mask_subtypes(n);
tic
res2 = squeeze(evalChebPowerbnd(Q,x,Tq,.05));
toc

