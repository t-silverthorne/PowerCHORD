addpath('../utils')
n = 5;
Q = rand(n,n);
Q = Q*Q';
x = rand(n,1);
[~,T] = getSymm4Mask_subtypes(n);
tic;weinSumSlow(Q,x,T)
weinSumFast(Q,x)
toc