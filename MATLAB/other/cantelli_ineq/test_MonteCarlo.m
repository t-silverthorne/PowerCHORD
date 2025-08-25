addpath('../two_moment_method/')

n     = 6;
nsamp = 10;
S1 = randn(n/2,n/2)/100;
S1 = S1*S1';
S2 = randn(n/2,n/2)*5.2;
S2 = S2*S2';
x = mvnrnd(rand(n,1),blkdiag(S1,S2),nsamp);
x = x';
x = reshape(x,[n,1,1,1,nsamp]);
Q = rand(n,n)/10;
Q = Q*Q';
[~,Tq]= getSymm4Mask_subtypes(n);
tic
m1 =getExactPermMoment1(Q,x);
m2 =getExactPermMoment2(Q,x,Tq);
toc

Nmc   = 1e5;
m1_mc = 0;
m2_mc = 0;
for ii=1:Nmc
    xloc = x(randperm(n),1,1,1,:);
    vv  = pagemtimes(pagetranspose(xloc),pagemtimes(Q,xloc));
    m1_mc = m1_mc + vv;
    m2_mc = m2_mc + vv.^2;
end
m1_mc = m1_mc/Nmc;
m2_mc = m2_mc/Nmc;
squeeze(m1)'
squeeze(m1_mc)'

squeeze(m2)'
squeeze(m2_mc)'