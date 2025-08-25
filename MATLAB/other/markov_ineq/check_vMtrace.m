% check von Neumann trace ineq keeps ineq < 1
n     = 120;
tt    = rand(1,n);
x     = 3*cos(2*pi*tt)'+randn(n,1);
fvals = [1 2 3];

% quadratic form
Lf    = @(ff) getSpecQform(tt,ff);
L = 0;
for ff=fvals
    L = L+Lf(ff);
end
L = L/length(fvals);

% compute numerator and denominator
w1  = factorial(n-1)/factorial(n);
w2  = factorial(n-2)/factorial(n);
J   = ones(n,n)-eye(n);
NUM = (w1*trace(L)*(x'*x) + w2*trace(L*J)*x'*J*x);
DEN = x'*L*x;

% get eigs
eJ = eig(J);
eL = eig(L);
if x'*J*x > 0
    NUMvm = (w1*trace(L)*(x'*x) + w2*(eL'*eJ )*x'*J*x);
else
    NUMvm = (w1*trace(L)*(x'*x) + w2*(eL'*flip(eJ))*x'*J*x);
end
NUMvm/DEN
NUM/DEN