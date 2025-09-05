% compare chebBound to MC power
clear;clf;
tic;
rng('default')
addpath('../utils')
Nmeas = 32;
Nfreq = 32;
Nacro = 16;
Nsamp = 2e2;
fmin  = 1;
fmax  = Nmeas/4;
Amp   = 10;
tt    = rand(Nmeas,1);
fqf_2 = reshape(linspace(fmin,fmax,1e3),1,1,[]);
Q2    = getQuadForm(tt,fqf_2);

% simulate signal
freqs = linspace(fmin,fmax,Nfreq);
acros = linspace(0,2*pi,Nacro+1);
acros = acros(1:end-1);
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);

mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);
x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);

[pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05);
pwr2 = pwr2.*((-1).^(~sgn));
pwr2 = squeeze(pwr2);
plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--k','LineWidth',1)
hold on 

nrep = 100
for jj=1:nrep
    freq  = freqs(randsample(1:length(freqs),1));
    acro  = acros(randsample(1:length(acros),1));
    mu    = Amp*cos(2*pi*freq*tt -acro);
    x     = mu + randn([sz(1:4),Nsamp]);
    Nperm = 5e3;
    pwr   = fastMCT2power(Q2,x,Nperm,.05);
    plot(freq,pwr,'.r')
    drawnow
end
ylim([0,1])
xlim([fmin,fmax])