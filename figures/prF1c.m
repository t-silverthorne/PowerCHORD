% compare wcp optimal vs equispaced for freq window [1,N/2] for various
% values of N, bandlimit the equispaced design to avoid numerical instability
clear;clf;
mode  = 'test';
Nmeas = 16;
cfact = .95;
Amp   = 2;
fmin  = 1;
fmax  = Nmeas/2;

% load designs
data  = readtable('diffEvolveOutput.csv');
mt    = data(data.Nmeas==Nmeas & data.fmin==fmin & data.fmax == fmax,:);

addpath('../MATLAB/utils')
switch mode
	case 'test' % number of pvals = nrep*Nsamp 
		Nsamp  = 1e2;
		Nperm  = 1e2;
		Nfreq  = 24;
		Nacro  = 32;
		Nfq    = 500;
        nrep   = 10; 
	case 'real'
		Nsamp  = 1e3;
		Nperm  = 1e3;
		Nfreq  = 16;
		Nacro  = 2;
		Nfq    = 500;
end

% estimate free period power for WCP optimal design
tt   = mt{:,9:(9+Nmeas-1)}';
if length(tt)~=Nmeas
	error('check table')
end    

tic;
% estimate free period power for equispaced design
pwr  = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,1,Amp,Nfreq,Nacro,Nfq,nrep);
tu   = linspace(0,1,Nmeas+1);
tu   = tu(1:end-1)';
pwru = estimateFreePeriodPower(tu,Nsamp,fmin,fmax,Nperm,cfact,Amp,Nfreq,Nacro,Nfq,nrep);
freqs = linspace(fmin,fmax,Nfreq);

pwr  = reshape(pwr,[],1);
pwru = reshape(pwru,[],1);
%% write data to file
outFile = sprintf('prF1c_n%d.csv', n);
writematrix([pwru pwr], outFile);
fprintf('Saved results to %s\n', outFile);

% plot(squeeze(freqs),squeeze(pwr),'-k')
% hold on
% plot(squeeze(freqs),squeeze(pwru),'-b')
% drawnow
% ylim([0,1])
% toc