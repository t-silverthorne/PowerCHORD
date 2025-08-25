% compare monte carlo power estimate versus power bound from two moment 
% inequality


% applying random design to all acrophases of signal at freq=1
clear
clf
rng('default')
addpath('../two_moment_method/')
addpath('../cantelli_ineq/')
addpath('../perm_test_utils/')
n     = 25;
nsamp = 1e3;
Nperm = 1e3;
freq  = 1;
tt    = .25*rand(n,1);
acros = linspace(0,2*pi,2^7+1);
acros = acros(1:end-1);

[~,Tlin] = getSymm4Mask_subtypes(n);
H        = [0 1 0; 0 0 1];
X        = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
L        = H*((X'*X)\(X'));
L        = L'*L;
alpha    = .05;
Sigma    = eye(n);



ii = 1;
pwr_mc    = NaN(length(acros),1);
pwr_ineq  = NaN(length(acros),1);
Amp = 5;
sd  = .1;
for acro=acros
    mu = Amp*cos(2*pi*freq*tt-acro);
    % two-moments bound
    pwr_ineq(ii) = get2mBound(L,sd^2*Sigma,mu,alpha,Tlin)
    ii=ii+1;
    hold on
    plot(acros,pwr_ineq,'--k')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end

ii=1
pwr_cheb = NaN(size(acros))
[~,Tq]=getSymm4Mask_subtypes(n);
for acro=acros
    mu = Amp*cos(2*pi*freq*tt-acro);
    y  = mu+sd*randn(n,nsamp);
    y  = reshape(y,n,1,1,1,[]);
    % two-moments bound
    [cb,sgn]=evalChebPowerbnd(L,y,Tq,alpha);
    pwr_cheb(ii) = cb*(-1)^(~sgn);
    ii=ii+1;
    hold on
    plot(acros,pwr_cheb,'--b')
    ylim([0,1])
    xlim([0,2*pi])
    drawnow
end
%%
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

