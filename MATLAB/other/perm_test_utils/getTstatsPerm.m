function [E_P_E_pi,Var_P_E_pi,E_P_Var_pi] = getTstatsPerm(TMAT1,TMAT2,TMAT3)
%GETTMMEMPIRICAL first dim corresp samples, second to perms
E_P_E_pi   = mean(TMAT1,'all');
Var_P_E_pi = mean(mean(TMAT2,2).^2) - mean(TMAT2,'all').^2;
E_P_Var_pi = mean(mean(TMAT3.^2,2)-mean(TMAT3,2).^2);
end

