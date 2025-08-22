clear
clf
rng('default')
addpath('../two_moment_method/')
addpath('../perm_test_utils/')
n     = 48;
fmin  = 1;
fmax  = 10;
[~,Tlin]   = getSymm4Mask_subtypes(n);
H          = [0 1 0; 0 0 1];
freqs_ineq = linspace(fmin,fmax,10^5);
freqs_ineq = reshape(freqs_ineq,1,1,[]);
acros = linspace(0,2*pi,2^4+1);
acros = acros(1:end-1);

tt = linspace(0,1,n+1);
tt = tt(1:end-1)';

alpha = .05;
Sigma = eye(n);

Lcent = getSpecPaged(tt,freqs_ineq);

Amp   = 1000;
sd    = .01;
ftrue = 2;
pwr_ineq  = NaN(length(acros),1);
ii=1;
for acro=acros
    mu = Amp*cos(2*pi*ftrue*tt-acro);
    % two-moments bound
    pwr_ineq(ii) = get2mBoundCent(Lcent,sd^2*Sigma,mu,alpha,Tlin)
    ii=ii+1;
    hold on
    plot(acros,pwr_ineq,'--k')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end