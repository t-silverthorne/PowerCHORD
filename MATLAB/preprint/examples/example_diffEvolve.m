addpath('../utils')
addpath('../optim_methods')

settings=struct();
settings.Npop       = 1e2; % number of designs to consider
settings.Niter      = 5e1; % number of iterations
settings.time_max   = Inf; % turn off the walltime limit
settings.useGPUglob = false; % turn off GPU
settings.eps        = .05; % default params for differential evolution
settings.CR         = .05; % default params for differential evolution


% specify the optimization problem
Nm    = 48;
fmin  = 1;
fmax  = 24;
Nfreq = 2^10;

% run
[Tmat,eigfinal,scores]=diffEvolve(Nm,fmin,fmax,Nfreq,settings);

plot(1:settings.Niter, scores)
xlabel('iteration')
ylabel('score')