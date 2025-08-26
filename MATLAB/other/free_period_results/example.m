clear
clf
rng('default')
addpath('../two_moment_method/')
addpath('../perm_test_utils/')
n          = 24;
nsamp      = 3e2;
Nperm      = 1e3;
fmin       = 1;
fmax       = 6;
[~,Tlin]   = getSymm4Mask_subtypes(n);
H          = [0 1 0; 0 0 1];
freqs_ineq = linspace(fmin,fmax,10^5);
freqs_ineq = reshape(freqs_ineq,1,1,[]);
acros = linspace(0,2*pi,2^4+1);
acros = acros(1:end-1);

tt = linspace(0,1,n+1);
tt = tt(1:end-1)';
tt = rand(n,1);

alpha = .05;
Sigma = eye(n);

Lcent = getSpecPaged(tt,freqs_ineq);

Amp   = 10;
sd    = .1;
ftrue = 1.5;
pwr_ineq  = NaN(length(acros),1);
pwr_ineq2 = NaN(length(acros),1);
freqs_mc = linspace(fmin,fmax,200);
freqs_mc = reshape(freqs_mc,1,1,[]);
pwr_mc   = NaN(length(acros),1);

ii=1;
for acro=acros
    mu = Amp*cos(2*pi*ftrue*tt-acro);
    % two-moments bound
    pwr_ineq(ii)  = get2mBoundCent(Lcent,sd^2*Sigma,mu,alpha,Tlin)
    pwr_ineq2(ii) = get2mBound(Lcent,sd^2*Sigma,mu,alpha,Tlin)
    
    plot(acros,pwr_ineq,'--k')
    hold on
    plot(acros,pwr_ineq2,'--b')
    
    y  = mu+sd*randn(n,nsamp);

    % MC estimate
    pval = getPermPval(tt,y,freqs_mc,Nperm,'T2cent');
    pwr_mc(ii) = mean(pval<alpha)
    plot(acros,pwr_mc,'-k')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
    ii=ii+1;
end