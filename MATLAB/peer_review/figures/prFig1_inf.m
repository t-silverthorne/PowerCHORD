% benchmark the wcp designs using the exact power formula
clear;clf;
addpath('../../preprint/utils/')
addpath('../utils')
addpath('../../other/perm_test_utils/')

% load each design
data = readtable('diffEvolveOutput.csv');

Nmeas = 32;
fmin  = 1;
fmax  = 16;
mt = data(data.Nmeas==Nmeas & data.fmin==fmin & data.fmax == fmax,:);
tt = mt{:,9:(9+Nmeas-1)}';
if length(tt)~=Nmeas
    error('check table')
end

% eval WCP power
[~,em_fv]=getMinEigMulti(tt,8,18,1e3);


% estimate free period power
Amp   = 2;
Nfreq = 16;
Nacro = 16;
Nperm = 1e2;
Nsamp = 1e2;
freqs = linspace(fmin,fmax,Nfreq);
acros = linspace(0,2*pi,Nacro+1);
acros = acros(1:end-1);
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);
mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);
x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);
fqf   = linspace(fmin,.9*fmax,1e3);
fqf   = reshape(fqf,1,1,[]);
[~,Q] = getQuadForm(tt,reshape(freqs,1,1,[]));
alpha = .05;
pwrMC = squeeze(fastMCTinfpower(Q,x,Nperm,alpha));


f0   = finv(1-alpha,2,Nmeas-3);
pwrF = squeeze(arrayfun(@(freq) ncfcdf(f0,2,Nmeas-3,Amp^2*getMinEig(tt,freq),'upper'),freqs));
plot(squeeze(freqs),min(pwrMC,[],2),'-b')
hold on
plot(squeeze(freqs),pwrF,'--b')
ylim([0,1])


tu      = linspace(0,1,Nmeas+1);
tu      = tu(1:end-1)';
mu_unif = Amp*cos(2*pi*freqs.*tu -acros);
xu      = mu_unif + randn([sz(1:4),Nsamp,sz(6:end)]);
[~,Qu]  = getQuadForm(tu,reshape(freqs,1,1,[]));
pwrMCu  = squeeze(fastMCTinfpower(Qu,xu,Nperm,alpha));
pwrFu   = squeeze(arrayfun(@(freq) ncfcdf(f0,2,Nmeas-3,getMinEig(tu,freq),'upper'),freqs));
plot(squeeze(freqs),min(pwrMCu,[],2),'-k')
plot(squeeze(freqs),pwrFu,'--k')