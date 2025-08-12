n = 48;

tt    = linspace(0,1,n+1);
tt    = tt(1:end-1)';

%tt    = rand(n,1);
X     = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
H     = [0 1 0; 0 0 1];
L     = H*((X'*X)\(X'));
L     = L'*L;
Sigma = eye(n)/sqrt(2);
%%
th = rand*2*pi
mu    = X*[1 4*cos(th) 400*sin(th)]';
alpha = .05;


[E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi] = getExactCenteredMoments(L,Sigma,mu);

lhs   = E_p - E_p_E_pi;
rhs   = sqrt(3*Var_p_E_pi) + sqrt(3*Var_p) + sqrt(3*E_p_Var_pi/alpha);
bnd   = 1-(rhs/lhs).^2
