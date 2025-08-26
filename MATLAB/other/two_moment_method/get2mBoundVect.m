function [bnd,sign_check] = get2mBoundVect(L,Sigma,mu,alpha,T,A1,A2,A3,B1,B2,B3)
%GET2MBOUNDVECT vectorization is only wrt mu
G          = getIsserlisTensor(Sigma,mu); 
[E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi] = ...
    getExactCenteredMomentsVect(L,Sigma,mu,T,A1,A2,A3,B1,B2,B3);
lhs        = E_p - E_p_E_pi;
rhs        = sqrt(3*Var_p_E_pi) + sqrt(3*Var_p) + sqrt(3*E_p_Var_pi/alpha);
bnd        = 1-(rhs/lhs).^2;
sign_check = E_p > E_p_E_pi;
end

