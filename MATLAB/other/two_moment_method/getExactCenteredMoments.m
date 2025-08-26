function [E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi] = getExactCenteredMoments(L,Sigma,mu,T)
%GETEXACTCENTEREDMOMENTS Summary of this function goes here
%   Detailed explanation goes here
arguments
    L     (:,:) double;
    Sigma (:,:) double;
    mu    (:,1) double;
    T     (:,:,:,:,:) logical;
end
[m10,m11,m21,m20,m12]=getExactMoments(L,Sigma,mu,T);
E_p        = m10;
E_p_E_pi   = m11;
E_p_Var_pi = m12-m21;
Var_p      = m20 - m10^2;
Var_p_E_pi = m21 - m11^2;
end

