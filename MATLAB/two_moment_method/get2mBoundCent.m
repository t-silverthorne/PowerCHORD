function bnd = get2mBoundCent(L,Sigma,mu,alpha,Tlin)
%GET2MBOUND lower bound on power from two moments method
[E_p,~,E_p_Var_pi,Var_p,~] = getExactCenteredMoments(L,Sigma,mu,Tlin);
lhs        = E_p;
rhs        = sqrt(2*Var_p)+sqrt(2*E_p_Var_pi/alpha);
bnd        = 1-(rhs/lhs).^2;
end

