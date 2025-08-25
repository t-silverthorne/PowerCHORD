n =8;
tt=linspace(0,1,n);

fvals = [1 1.25 2];
x = randn(n,1);
Lf = @(ff) getSpecQform(tt,ff);

dvals = arrayfun(@(ff) x'*Lf(ff)*x,fvals);
mm    = max(dvals)
t=10
log(sum(arrayfun(@(ff) exp(t*x'*Lf(ff)*x/mm),fvals)))/t
%%
x = randn(n,1)*10
w1 = factorial(n-1)/factorial(n); w2 = factorial(n-2)/factorial(n);
J  = ones(n,n)-eye(n);

L  = Lf(1)
ee = eig(L)
mm = ee(end-1);
(w1*trace(L)*(x'*x) + w2*trace(L*J)*x'*J*x)/mm/(x'*x)