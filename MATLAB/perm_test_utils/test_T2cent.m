% null
clear;clf
n = 10
Nsamp = 1e4;
Nperm = 1e4;
tt = rand(n,1);
y  = 0+randn(n,Nsamp);
tiledlayout(1,2)
nexttile
pval = getPermPval(tt,y,1,Nperm,'T2cent')
histogram(pval,20)
xlim([0,1])
% signal
y = randn(n,Nsamp) + 2*cos(2*pi*tt)
pval = getPermPval(tt,y,1,Nperm,'T2cent')
nexttile
histogram(pval,20)
xlim([0,1])