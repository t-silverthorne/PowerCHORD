% compare monte carlo power estimate versus power bound from two moment 
% inequality


% applying random design to all acrophases of signal at freq=1
clear
clf
rng('default')
addpath('../two_moment_method/')
addpath('../perm_test_utils/')
n     = 20;
nsamp = 1e2;
Nperm = 1e3;
freq  = 1;

tt = linspace(0,1,n+1);
tt = .75*tt(1:end-1)';

acros = linspace(0,2*pi,2^7+1);
acros = acros(1:end-1);

[~,Tlin] = getSymm4Mask_subtypes(n);
H        = [0 1 0; 0 0 1];
X        = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
L        = H*((X'*X)\(X'));
L        = L'*L;
alpha    = .2;
Sigma    = eye(n);



ii = 1;
pwr_mc    = NaN(length(acros),1);
pwr_ineq  = NaN(length(acros),1);
Amp = 10;
sd  = 1;
Lcent = getSpecPaged(tt,freq);
for acro=acros
    mu = Amp*cos(2*pi*freq*tt-acro);
    % two-moments bound
    pwr_ineq(ii) = get2mBoundCent(Lcent,sd^2*Sigma,mu,alpha,Tlin)
    ii=ii+1;
    hold on
    plot(acros,pwr_ineq,'--k')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end


ii=1
for acro=acros
    mu = Amp*cos(2*pi*freq*tt-acro);
    y  = mu+sd*randn(n,nsamp);

    % MC estimate
    pval = getPermPval(tt,y,freq,Nperm,'T2');
    pwr_mc(ii) = mean(pval<alpha)
    ii=ii+1
    plot(acros,pwr_mc,'-k')
    hold on
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end
