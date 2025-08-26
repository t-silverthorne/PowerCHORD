n = 48;

tt    = linspace(0,1,n+1);
tt    = tt(1:end-1)';

%tt    = rand(n,1);
X     = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
H     = [0 1 0; 0 0 1];
L     = H*((X'*X)\(X'));
L     = L'*L;
Sigma = eye(n);

th = rand*2*pi
mu    = X*[0 5*cos(th) 1.9*sin(th)]';
alpha = .05;

tic
[E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi] = getExactCenteredMoments(L,Sigma,mu);
toc
%%
lhs   = E_p - E_p_E_pi;
rhs   = sqrt(3*Var_p_E_pi) + sqrt(3*Var_p) + sqrt(3*E_p_Var_pi/alpha);
bnd   = 1-(rhs/lhs).^2;
