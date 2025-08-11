%% compare exact and Monte Carlo poewr for single freq
clear all
rng('default')
% exact power
n     = 22;
tt    = rand(n,1);
Amp   = 1.25;
alpha = .06;
acro  = pi/2;
freq  = 1.5;
fprintf('Exact:        %d\n',evalFtestPower(tt,freq,acro,Amp,alpha))

% Monte Carlo power
Nperm = 1e4;
nrep  = 1e2;
nloop = 1e2;
fmin  = freq;
fmax  = freq;
Nfreq = 1;
pval  = [];
for ll = 1:nloop
    ll
    y              = Amp*cos(2*pi*freq*tt-acro)+randn(n,1,1,nrep,1);
    Yperm          = perm5d(y,Nperm);
    [~,~,rss_obs]  = fitCosinorWindowFreqPaged(tt,y,fmin,fmax,Nfreq);
    [~,~,rss_perm] = fitCosinorWindowFreqPaged(tt,Yperm,fmin,fmax,Nfreq);
    rss_perm       = squeeze(rss_perm);
    rss_obs        = squeeze(rss_obs);
    pval           = [pval;mean(rss_perm<rss_obs,2)];
end
ean(pval<alpha)
fprintf('Monte Carlo:  %d\n',mean(pval<alpha))

%% rough compare min exact vs Monte Carlo across freqs
rng('default')
clf
clear
fmin=1;
fmax=5;
n     = 12;
tt    = rand(n,1);
Amp   = 1.5;
alpha = .05;
acro  = pi/2;

%fminsearch(@(f) evalFtestPower(tt,f,acro,Amp,alpha),fmax)
%[bad_freq,fval]=fminbnd(@(f) evalFtestPower(tt,f,acro,Amp,alpha),fmin,fmax,);

Nfplt = 1e3;
freqs = linspace(fmin,fmax,Nfplt);
pwrs  = arrayfun(@(x) evalFtestPower(tt,x,acro,Amp,alpha),freqs);
plot(freqs,pwrs)

Nfreq = 100;
nrep  = 10;
nloop = 1000;
Nperm = 5e3;
fvec = linspace(fmin,fmax,5);
ests = arrayfun(@(ff) locPwrEst(tt,acro,Amp,alpha,ff,fmin,fmax,...
    Nfreq,nrep,Nperm,nloop),fvec);
hold on
plot(fvec,ests,'.k')


function pwr=locPwrEst(tt,acro,Amp,alpha,ftrue,fmin,fmax,Nfreq,nrep,Nperm,nloop)
pval =[];
n = length(tt);
for ll = 1:nloop
    ll
    y              = Amp*cos(2*pi*ftrue*tt-acro)+randn(n,1,1,nrep,1);
    Yperm          = perm5d(y,Nperm);
    [~,~,rss_obs]  = fitCosinorWindowFreqPaged(tt,y,fmin,fmax,Nfreq);
    [~,~,rss_perm] = fitCosinorWindowFreqPaged(tt,Yperm,fmin,fmax,Nfreq);
    rss_perm       = squeeze(rss_perm);
    rss_obs        = squeeze(rss_obs);
    pval           = [pval;mean(rss_perm<rss_obs,2)];
end
pwr=mean(pval<alpha);
end