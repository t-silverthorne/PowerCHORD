clear;
addpath('../perm_test_utils/')
rng('default')
n        = 40; 
fmin     = 1;
fmax     = 2;
freqs_mc = linspace(fmin,fmax,100);
nsamp    = 1e2;
Nperm    = 1e3;

tt = linspace(0,1,n+1);
tt = tt(1:end-1)';

Amp   = 5;
ftrue = fmin;%mean([fmax,fmin]);
acro  = 0;
mu    = Amp*cos(2*pi*ftrue*tt-acro);
alpha = .05;
L = 0;
H = [0 1 0; 0 0 1];
for freq=freqs_mc
    X      = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
    Lloc   = H*((X'*X)\(X'));
    Lloc   = Lloc'*Lloc;
    L      = L + Lloc;
end
L = L/length(freqs_mc);
[~,Tlin]   = getSymm4Mask_subtypes(n);
get2mBound(L,eye(n),mu,alpha,Tlin)


y1 = mu+randn(n,nsamp);
% y2 = mu+randn(n,nsamp);
% y3 = mu+randn(n,nsamp);
% y4 = mu+randn(n,nsamp);
% y5 = mu+randn(n,nsamp);

getTMMempirical(tt,y1,y1,y1,y1,y1,freqs_mc,Nperm,'T2',alpha)
%%
power_mc = mean(getPermPval(tt,y1,freqs_mc,Nperm,'Tinf')<alpha)
power_mc = mean(getPermPval(tt,y1,freqs_mc,Nperm,'T2')<alpha)
%%

