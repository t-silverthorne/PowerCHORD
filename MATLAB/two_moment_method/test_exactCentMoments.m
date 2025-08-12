n = 4;
L = randn(n,n);
L = L*L';
Sigma = randn(n,n)/n;
Sigma = Sigma*Sigma';
mu = 10+randn(n,1);

tic
nsamp=1e6;
[~,~,E_p_Var_pi,Var_p,Var_p_E_pi] = getExactCenteredMoments(L,Sigma,mu);
[mcE_p_Var_pi,mcVar_p,mcVar_p_E_pi] = getmcCenteredMoments(L,Sigma,mu,nsamp)

fprintf('1: %d\n',abs(E_p_Var_pi-mcE_p_Var_pi)./mcE_p_Var_pi)
fprintf('2: %d\n',abs(Var_p-mcVar_p)./mcVar_p)
fprintf('3: %d\n',abs(Var_p_E_pi-mcVar_p_E_pi)./mcVar_p_E_pi)
toc
