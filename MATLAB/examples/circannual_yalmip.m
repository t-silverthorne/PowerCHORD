% optimize for 24hr and 2hr rhythms
addpath('../utils')
addpath('../optim_methods')

Nfreq = 3;

freqs = [1,12,52,365];

Nmeas = 4*12  ;     % sample size
n     = 8*365 ;     % grid coarseness

% get optimal solution as binary vector
[mu,eta]=run_yalmip(freqs,Nmeas,n)