clear
addpath('../utils')
n     = 12;
tt    = linspace(0,1,n+1);
tt    = tt(1:end-1)';
Nsamp = 1e3;
Nperm = 1e3;


fmin = 1;
fmax = n/3;
Amp  = NaN;
cf   = 1;

acro = 0;
freq = 1;
fqf  = linspace(fmin,fmax,5e1);

% want to sweep amplitude and frequency band
pwrFree  = estFPPloc(tt,Nsamp,freq,acro,Amp,Nperm,cf,fqf)
pwrFtest = evalFtestPower(tt,freq,acro,Amp)

%x = Amp*cos(2*pi*freq*tt

function [pwr,pwrGrid] = estFPPloc(tt,Nsamp,freq,acro,Amp,Nperm,cf,fqf)
% wrapper for estimating power of free period model, calls fastMCTinfpower
% for actual power evaluation
mu      = Amp*cos(2*pi*freq*tt -acro); % simulated signal
mu      = reshape(mu,[],1);
x       = mu + randn([1,1,1,1,Nsamp]);

fqf     = reshape(fqf,1,1,[]);
[~,Q]   = getQuadForm(tt,fqf);
alpha   = .05;
pwrGrid = squeeze(fastMCTinfpower(Q,x,Nperm,alpha));
pwr     = min(pwrGrid,[],2);
end

