%% compare exact and Monte Carlo poewr for single freq
clear all
rng('default')
% exact power
n     = 22;
tt    = rand(n,1);
Amp   = 1.75;
alpha = .06;
acro  = pi/2;
freq  = 1.5;
fprintf('Exact:        %d\n',evalFtestPower(tt,freq,acro,Amp,alpha))

% Monte Carlo power
Nperm = 5e3;
nrep  = 1e1;
nloop = 1e2;
fmin  = freq;
fmax  = freq;
Nfreq = 1;
pval  = [];
for ll = 1:nloop
    y              = Amp*cos(2*pi*freq*tt-acro)+randn(n,1,1,nrep,1);
    Yperm          = perm5d(y,Nperm);
    [~,~,rss_obs]  = fitCosinorWindowFreqPaged(tt,y,fmin,fmax,Nfreq);
    [~,~,rss_perm] = fitCosinorWindowFreqPaged(tt,Yperm,fmin,fmax,Nfreq);
    rss_perm       = squeeze(rss_perm);
    rss_obs        = squeeze(rss_obs);
    pval           = [pval;mean(rss_perm<rss_obs,2)];
end

fprintf('Monte Carlo:  %d\n',mean(pval<alpha))

%% compare min exact vs Monte Carlo for several freq


