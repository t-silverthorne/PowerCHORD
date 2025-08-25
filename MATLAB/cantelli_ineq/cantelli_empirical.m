clear
addpath('../perm_test_utils/')
addpath('../markov_ineq/')
addpath('../free_period_results/')
addpath('../two_moment_method')
rng('default')
example='broad';
switch example
    case 'tight'
        n     = 48;
        Amp   = 1.05;
        tt    = linspace(0,1,n+1);
        tt    = tt(1:end-1)';
        tt    = rand(n,1);
        tt    = tt;
        acro  = pi/2;
        alpha = .05;
        fmin  = 1;
        fmax  = n/2;
        freqs = linspace(fmin,fmin,2);
        Nsamp = 2e3;
        Nperm = 1e3;
        ftrue = fmin;
    case 'broad'
        n     = 40;
        Amp   = 3.25;
        tt    = linspace(0,1,n+1);
        tt    = tt(1:end-1)';
        %tt    = rand(n,1);
        acro  = pi/2;
        alpha = .05;
        fmin  = 1;
        fmax  = n/2;
        freqs = linspace(fmin,fmax,2);
        Nsamp = 1e3;
        Nperm = 1e3;
        ftrue = fmax;
end

freqs = reshape(freqs,1,1,[]);
[~,L] = getSpecPaged(tt,freqs);
y     = Amp*cos(2*pi*ftrue*tt-acro) + randn(n,Nsamp);

tic
pvals = getPermPval(tt,y,freqs,Nperm,'T2');
pwr        = mean(pvals<alpha)
toc
tic
[PSI,sgn]  = getPSI(tt,y,freqs,Nperm);
Vp   = mean(PSI.^2) - mean(PSI)^2;
Ep   = mean(PSI);
Ep   < alpha
cbnd = 1-Vp/(Vp + (alpha-Ep)^2)
toc
function [PSI,sgn] = getPSI(tt,y,freqs,Nperm)
TMAT =  getPermTMAT(tt,y,freqs,Nperm,'T2');
Vpi  = mean(TMAT.^2,2) - mean(TMAT,2).^2;
Epi  = mean(TMAT,2);
Tobs = computeT2(tt,y,freqs)';
sgn  = Epi<Tobs;
PSI  = Vpi./(Vpi + (Tobs-Epi).^2);
end
% TMAT =  getPermTMAT(tt,y,freqs,Nperm,'T2');
% Vpi = mean(TMAT.^2,2) - mean(TMAT,2).^2;
% Epi = mean(TMAT,2);
% Tobs = computeT2(tt,y,freqs)';
%%
clf
plot(pvals',PSI,'.k')
hold on
plot([0,1],[0,1],'-k')
