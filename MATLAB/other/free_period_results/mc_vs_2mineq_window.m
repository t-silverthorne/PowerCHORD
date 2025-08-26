% applying random design to all acrophases of signal at freq=1
clear
clf
rng('default')
addpath('../two_moment_method/')
addpath('../perm_test_utils/')
n     = 50;
nsamp = 1e4;
Nperm = 1e2;
fmin  = 1;
fmax  = 12;
[~,Tlin]   = getSymm4Mask_subtypes(n);
H          = [0 1 0; 0 0 1];
freqs_ineq = linspace(fmin,fmax,10^5);

acros = linspace(0,2*pi,2^4+1);
acros = acros(1:end-1);

tt = linspace(0,1,n+1);
tt = tt(1:end-1)';
L=0;
for freq=freqs_ineq
    X      = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
    Lloc   = H*((X'*X)\(X'));
    Lloc   = Lloc'*Lloc;
    L      = L + Lloc;
end
L = L/length(freqs_ineq);

alpha = .05;
Sigma = eye(n);

Amp   = 10;
sd    = .01;
ftrue = 25;
ii=1
pwr_ineq  = NaN(length(acros),1);
for acro=acros
    mu = Amp*cos(2*pi*ftrue*tt-acro);
    % two-moments bound
    pwr_ineq(ii) = get2mBound(L,sd^2*Sigma,mu,alpha,Tlin)
    ii=ii+1;
    hold on
    plot(acros,pwr_ineq,'--k')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end
%%

freqs_mc = linspace(fmin,fmax,5);
freqs_mc = reshape(freqs_mc,1,1,[]);
pwr_mc    = NaN(length(acros),1);
ii=1
for acro=acros
    mu = Amp*cos(2*pi*ftrue*tt-acro);
    y  = mu+sd*randn(n,nsamp);

    % MC estimate
    pval = getPermPval(tt,y,freqs_mc,Nperm,'T2');
    pwr_mc(ii) = mean(pval<alpha)
    ii=ii+1
    plot(acros,pwr_mc,'-k')
    hold on
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end
