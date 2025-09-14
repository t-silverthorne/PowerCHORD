% compare wcp optimal vs equispaced for freq window [1,N/2] for various
% values of N, bandlimit the equispaced design to avoid numerical instability
clear;clf;
mode  = 'test'
Nmeas = 16
cfact = .95;
Amp   = 2;
fmin  = 1;
fmax  = Nmeas/2;

% load designs
data  = readtable('diffEvolveOutput.csv');
mt    = data(data.Nmeas==Nmeas & data.fmin==fmin & data.fmax == fmax,:);

addpath('../MATLAB/utils')
switch mode
	case 'test'
		Nsamp  = 10;
		Nperm  = 10;
		Nfreq  = 8;
		Nacro  = 2;
		Nfq    = 10;
	case 'real'
		Nsamp  = 1e3;
		Nperm  = 1e3;
		Nfreq  = 16;
		Nacro  = 16;
		Nfq    = 500;
end

ts = string(datetime('now','Format','yyyyMMdd_HHmmss'));
fprintf('Running Nmeas = %d\n', Nmeas);

% estimate free period power for WCP optimal design
tt   = mt{:,9:(9+Nmeas-1)}';
if length(tt)~=Nmeas
	error('check table')
end    
pwr  = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,1,Amp,Nfreq,Nacro,Nfq);

% estimate free period power for equispaced design
tu   = linspace(0,1,Nmeas+1);
tu   = tu(1:end-1)';
pwru = estimateFreePeriodPower(tu,Nsamp,fmin,fmax,Nperm,cfact,Amp,Nfreq,Nacro,Nfq);

freqs = linspace(fmin,fmax,Nfreq)
plot(squeeze(freqs),squeeze(pwr),'-k')
plot(squeeze(freqs),squeeze(pwru),'-b')
hold on
drawnow
