% comparison of free period and F-test for equispaced designs
clear
addpath('../utils')
Nsamp = 5e2;
Nperm = 1e3;
% also make corr plot
n     = 12;
data  = [];
nvals = [12];
fmin  = 1;
Amin  = 1;
Amax  = 3;

tic;
nrep = 3e3;
for n=nvals
	fprintf('Running n=%d\n',n)
	tt   = linspace(0,1,n+1);
	tt   = tt(1:end-1)';
	fmaxs = [n/2,n/3,n/4];
	for ffidx=1:length(fmaxs)
		data  = NaN(nrep,8);
		fmax=fmaxs(ffidx);
		if fmax==n/2
			cf=.95;
		else
			cf=1;
		end
		fprintf('Running fmax=%d\n',fmax)
		parfor rep=1:nrep
			fprintf('   on rep %d\n',rep)
			Amp  = Amin + (Amax-Amin)*rand; 
			acro = 2*pi*rand;
			freq = fmin + (fmax-fmin)*rand;
			fqf  = linspace(fmin,cf*fmax,5e2);

			pwrFree  = estFPPloc(tt,Nsamp,freq,acro,Amp,Nperm,fqf);
			pwrFtest = evalFtestPower(tt,freq,acro,Amp);
			vv       = [n fmin fmax Amp acro freq pwrFree pwrFtest];
			data(rep,:) = vv;
		end
		writematrix(data, sprintf('data/results_prF1a_equi_%d.csv',ffidx));
	end
end
toc

function [pwr,pwrGrid] = estFPPloc(tt,Nsamp,freq,acro,Amp,Nperm,fqf)
% wrapper for estimating power of free period model, calls fastMCTinfpower
% for actual power evaluation
mu      = Amp*cos(2*pi*freq*tt -acro); % simulated signal
mu      = reshape(mu,[],1);
x       = mu + randn([length(tt),1,1,1,Nsamp]);

fqf     = reshape(fqf,1,1,[]);
[~,Q]   = getQuadForm(tt,fqf);
alpha   = .05;
pwrGrid = squeeze(fastMCTinfpower(Q,x,Nperm,alpha));
pwr     = min(pwrGrid,[],2);
end

