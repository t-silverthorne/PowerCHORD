% check how Tinf statistic behaves on randomly generated design
clear;clf;
Nmeas = 32;
Nfreq = 16;
Nacro = 16;
Nperm = 1e2;
Nsamp = 1e2;

fmin = 1;
fmax = 16;
Amp  = 2;
fqf_2    = reshape(linspace(fmin,fmax,1000),1,1,[]);
fqf_i    = reshape(linspace(fmin,fmax,10),1,1,[]);

% construct test statistic
tt       = rand(Nmeas,1);
Q2       = getQuadForm(tt,fqf_2);
[~,Qinf] = getQuadForm(tt,fqf_i);

% simulate signal
freqs = linspace(fmin,fmax,Nfreq);
acros = linspace(0,2*pi,Nacro+1);
acros = acros(1:end-1);
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);

mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);
x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);

% estimate power
tic
pwr2   = squeeze(fastMCT2power(Q2,x,Nperm,0.05));
pwrinf = squeeze(fastMCTinfpower(Qinf,x,Nperm,0.05));
toc
plot(squeeze(freqs),squeeze(min(pwr2,[],2)))
plot(squeeze(freqs),squeeze(min(pwrinf,[],2)))

