addpath('../utils')
addpath('../optim_methods')

Nmeas    = 14;
n        = 48;
freqs    = [1 2 3]*2;
[mu,eta] = run_yalmip(freqs,Nmeas,n);

tau = (1:n)/n - 1/n;
plot(tau(value(mu)>0),1,'.k')

value(eta)

mt = (1:Nmeas)/Nmeas - 1/Nmeas;

[getMinEig(mt',2),getMinEig(mt',4),getMinEig(mt',6)]
