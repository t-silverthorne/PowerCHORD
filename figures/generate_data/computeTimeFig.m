% compare Tinf, T2, T2bnd, and exact power estimation
clear;
addpath('../../MATLAB/utils/');

nvals  = [12 24 36 48];
dat =[];
for n=nvals
    fprintf('Running n = %d\n',n)
    freq  = rand;
    acro  = 2*pi*rand;
    Amp   = rand;
    tt    = rand(n,1);
    
    ntrep = 10; % number of times to benchmark
    
    Nsamp = 1e2;
    Nperm = 1e3;
    fqf   = linspace(1,2,1e2);
    
    wrap_Tinf = @(tt,freq,acro,Amp) estTinfloc(tt,Nsamp,freq,acro,Amp,Nperm,fqf);
    wrap_T2   = @(tt,freq,acro,Amp) estT2loc(tt,Nsamp,freq,acro,Amp,Nperm,fqf);
    wrap_T2b  = @(tt,freq,acro,Amp) Jfun(tt,freq,acro,fqf,Amp,Nsamp);
    
    fprintf('  timing 1\n')
    [mm1,iqr1] = repTimeFunc(@evalFtestPower,ntrep,tt,freq,acro,Amp);
    
    fprintf('  timing 2\n')
    [mm2,iqr2] = repTimeFunc(wrap_Tinf,ntrep,tt,freq,acro,Amp);
    
    fprintf('  timing 3\n')
    [mm3,iqr3] = repTimeFunc(wrap_T2,ntrep,tt,freq,acro,Amp);
    
    fprintf('  timing 4\n')
    [mm4,iqr4] = repTimeFunc(wrap_T2b,ntrep,tt,freq,acro,Amp);
    datloc =   [n mm1 iqr1(:) 1;
                n mm2 iqr2(:) 2;
                n mm3 iqr3(:) 3;
                n mm4 iqr4(:) 4];
    dat = [dat;datloc];
end

writematrix(dat, 'output_data.csv');

%%

function Jval = Jfun(tt,freq,acro,fqf,Amp,Nsamp)
	tt    = reshape(tt,[],1);
    fqf   = reshape(fqf,1,1,[]);
	Q2    = getQuadForm(tt,fqf);

	mu    = Amp*cos(2*pi*freq.*tt -acro);
	x     = mu + randn([length(tt),1,1,1,Nsamp]);
	[pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05,'rig');
	pwr2 = pwr2.*((-1).^(~sgn));
	Jval   =min(pwr2,[],'all');
end

function pwr = estTinfloc(tt,Nsamp,freq,acro,Amp,Nperm,fqf)
mu      = Amp*cos(2*pi*freq*tt -acro); % simulated signal
mu      = reshape(mu,[],1);
x       = mu + randn([length(tt),1,1,1,Nsamp]);

fqf     = reshape(fqf,1,1,[]);
[~,Q]   = getQuadForm(tt,fqf);
alpha   = .05;
pwrGrid = squeeze(fastMCTinfpower(Q,x,Nperm,alpha));
pwr     = min(pwrGrid,[],2);
end


function pwr = estT2loc(tt,Nsamp,freq,acro,Amp,Nperm,fqf)
mu      = Amp*cos(2*pi*freq*tt -acro); % simulated signal
mu      = reshape(mu,[],1);
x       = mu + randn([length(tt),1,1,1,Nsamp]);

fqf     = reshape(fqf,1,1,[]);
Q       = getQuadForm(tt,fqf);
alpha   = .05;
pwrGrid = squeeze(fastMCT2power(Q,x,Nperm,alpha));
pwr     = min(pwrGrid,[],2);
end

function [avgTime, iqrTime] = repTimeFunc(funcHandle, numRuns, varargin)
    times = zeros(1, numRuns);
    for i = 1:numRuns
        times(i) = timeit(@() funcHandle(varargin{:}));
    end
    avgTime = mean(times);
    [~,iqrTime] = iqr(times);
end