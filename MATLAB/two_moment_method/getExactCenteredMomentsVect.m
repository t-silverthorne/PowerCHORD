function [E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi] = getExactCenteredMomentsVect(L,Sigma,mu,T,A1,A2,A3,B1,B2,B3)
%GETEXACTCENTEREDMOMENTSVECT vectorization is only wrt mu 
[m10,m11,m21,m20,m12]=getExactMomentsVect(L,Sigma,mu,T,A1,A2,A3,B1,B2,B3);

E_p        = m10;
E_p_E_pi   = m11;
E_p_Var_pi = m12 - m21;
Var_p      = m20 - m10.^2;
Var_p_E_pi = m21 - m11.^2;
end

