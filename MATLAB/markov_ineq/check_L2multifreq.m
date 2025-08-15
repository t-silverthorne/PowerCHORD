clear 
addpath('../two_moment_method/')
%rng('default')
n     = 100;
tt    = linspace(0,1,n+1);
tt    = tt(1:end-1);
tt    = rand(1,n);
x     = 2*cos(2*pi*tt)'+randn(n,1);
fvals = [1 10];


% quadratic form
Lf    = @(ff) getSpecQform(tt,ff);
L = 0;
for ff=fvals
    L = L+Lf(ff);
end
L = L/length(fvals);

% compute numerator
w1  = factorial(n-1)/factorial(n);
w2  = factorial(n-2)/factorial(n);
J   = ones(n,n)-eye(n);
NUM = (w1*trace(L)*(x'*x) + w2*trace(L*J)*x'*J*x);

% compute denominator
DEN = x'*L*x;

NUM/DEN

