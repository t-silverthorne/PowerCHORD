% compare monte carlo power estimate versus power bound from two moment 
% inequality


% applying random design to all acrophases of signal at freq=1
clear
clf
rng('default')
addpath('../two_moment_method/')
addpath('../perm_test_utils/')
n     = 25;
nsamp = 1e2;
Nperm = 1e3;
freq  = 3;

tt    = rand(n,1);
Lcent = getSpecPaged(tt,freq);

H        = [0 1 0; 0 0 1];
X        = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
L        = H*((X'*X)\(X'));
L        = L'*L;

acros = linspace(0,2*pi,2^4+1);
acros = acros(1:end-1);

[~,Tlin] = getSymm4Mask_subtypes(n);
alpha    = .05;
Sigma    = eye(n);


% two-moments bound
ii = 1;
pwr_ineq  = NaN(length(acros),1);
pwr_ineq2 = NaN(length(acros),1);
Amp       = 5;
sd        = 1;
for acro=acros
    mu = Amp*cos(2*pi*freq*1.15*tt-acro);
    pwr_ineq(ii)  = get2mBoundCent(Lcent,sd^2*Sigma,mu,alpha,Tlin)
    pwr_ineq2(ii) = get2mBound(Lcent,sd^2*Sigma,mu,alpha,Tlin)
    ii=ii+1;
    
    plot(acros,pwr_ineq,'--k')
    hold on
    plot(acros,pwr_ineq2,'--b')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end

pwr_mc    = NaN(length(acros),1);
ii=1;
for acro=acros
    mu = Amp*cos(2*pi*freq*1.15*tt-acro);
    y  = mu+sd*randn(n,nsamp);

    % MC estimate
    pval = getPermPval(tt,y,freq,Nperm,'T2cent');
    pwr_mc(ii) = mean(pval<alpha)
    ii=ii+1
    plot(acros,pwr_mc,'-k')
    hold on
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end
