addpath('../utils')
nsamp = 1e2;
n = 5;
Q = rand(n,n);
Q = Q*Q';
x = rand(n,1,1,1,nsamp);
[~,T] = getSymm4Mask_subtypes(n);
a1=weinSumFastVect(Q,x);
a2=getExactPermMoment2(Q,x,T);