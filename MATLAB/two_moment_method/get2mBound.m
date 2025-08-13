function [bnd,sign_check] = get2mBound(L,Sigma,mu,alpha,T)
%GET2MBOUND lower bound on power from two moments method
G = getIsserlisTensor(Sigma,mu); 
[E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi] = getExactCenteredMoments(L,Sigma,mu,T);
lhs        = E_p - E_p_E_pi;
rhs        = sqrt(3*Var_p_E_pi) + sqrt(3*Var_p) + sqrt(3*E_p_Var_pi/alpha);
bnd        = 1-(rhs/lhs).^2;
sign_check = E_p > E_p_E_pi;
end

