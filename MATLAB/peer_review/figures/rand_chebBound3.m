% compare chebBound to MC power
clear;clf;
tic;
rng('default')
addpath('../utils')
Nmeas = 32;
Nfreq = 64;
Nacro = 32;
Nsamp = 1e2;
fmin  = 1;
fmax  = Nmeas/4;
Amp   = 10;
tt    = rand(Nmeas,1);
fqf_2 = reshape(linspace(fmin,fmax,1e3),1,1,[]);
Q2    = getQuadForm(tt,fqf_2);

% simulate signal
freqs = linspace(fmin,fmax,Nfreq);
%acros = linspace(0,2*pi,Nacro+1);
%acros = acros(1:end-1);
acros = rand(Nacro,1)*2*pi;
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);

mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);
for jj=1:3
	jj
	x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);
	[pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05);
	pwr2 = pwr2.*((-1).^(~sgn));
	pwr2 = squeeze(pwr2);
	plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--k','LineWidth',1)
	hold on
	drawnow
end

drawnow
nrep  = 100
Nsamp = 5e2;
Nperm = 1e3;
for jj=1:nrep
	fprintf("Running %d\n",jj);
    freq  = freqs(randsample(1:length(freqs),1));
    acro  = acros(randsample(1:length(acros),1));
    mu    = Amp*cos(2*pi*freq*tt -acro);
    x     = mu + randn([sz(1:4),Nsamp]);
    pwr   = fastMCT2power(Q2,x,Nperm,.05);
    plot(freq,pwr,'.r')
	if mod(jj,10)==0
		drawnow
	end
end
ylim([0,1])
xlim([fmin,fmax])
