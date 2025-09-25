addpath('../utils')
addpath('../optim_methods')

% optimize for 24hr and 2hr rhythms
Nfreq = 3;

freqs = [1,2,4,6,8,10,12];%randsample(1:12,3,false);
%freqs=[1 12]; % units of cycles/day

Nmeas=30;     % sample size
n    =48*3;     % grid coarsensss

% get optimal solution as binary vector
[mu,eta]=run_yalmip(freqs,Nmeas,n)
%%

tau = (1:n)/n - 1/n;

% convert to time (units of days)
tau(value(mu)>0) % optimal solution

% convert to circadian time (units of hours)
24*tau(value(mu)>0)

% sanity check
value(eta)==6