addpath('../utils')
nsamp = 1e3;
n = 10;
Q = rand(n,n);
Q = Q*Q';
x = rand(n,1,1,1,nsamp);
[~,T] = getSymm4Mask_subtypes(n);
tic;a1=weinSumFastVect(Q,x);toc
tic;a2=getExactPermMoment2(Q,x,T);toc
%max(abs(squeeze(a1-a2)))