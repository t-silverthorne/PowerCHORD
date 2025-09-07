% compare chebBound to MC power
clear;clf;
tic;
rng('default')
addpath('../utils')
Nmeas = 48;
Nfreq = 32;
Nacro = 32;
Nsamp = 5e1;
fmin  = 1;
fmax  = Nmeas/4;
Amp   = 5;
% tt    = rand(Nmeas,1);
tt    = linspace(0,1,Nmeas+1);
tt    = tt(1:end-1)';
fqf_2 = reshape(linspace(fmin,fmax,1e3),1,1,[]);
Q2    = getQuadForm(tt,fqf_2);

%%
% simulate signal
freqs = linspace(fmin,fmax,Nfreq);
acros = rand(Nacro,1)*2*pi;
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);

mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);
for jj=1:2
	if jj==1
		method='rig';
	else
		method='naive';
	end
	x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);
	[pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05,method);
	pwr2 = pwr2.*((-1).^(~sgn));
	pwr2 = squeeze(pwr2);
	if jj==1
		plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'-k','LineWidth',1)
	else
		plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--k','LineWidth',1)
	end
	hold on
end
ylim([0,1])
xlim([fmin,fmax])

%nrep  = 100;
%Nsamp = 1e3;
%Nperm = 1e3;
%for jj=1:nrep
%	fprintf("Running %d\n",jj);
%    freq1  = (1-.05*rand)*fmax;%freqs(randsample(1:length(freqs),1));
%    freq2  = (1+.15*rand);%freqs(randsample(1:length(freqs),1));
%    %freq  = fmin+rand*(fmax-fmin);
%    freq  = randsample([freq1,freq2],1);
%    acro  = rand*2*pi;
%    mu    = Amp*cos(2*pi*freq*tt -acro);
%    x     = mu + randn([sz(1:4),Nsamp]);
%    pwr   = fastMCT2power(Q2,x,Nperm,.05);
%    plot(freq,pwr,'.r')
%	drawnow
%
%end
%ylim([0,1])
%xlim([fmin,fmax])
