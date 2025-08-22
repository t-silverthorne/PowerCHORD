function bnd =getTMMempirical(tt,y1,y2,y3,y4,y5,freqs,Nperm_tot,method,alpha)
switch method
    case 'T2'
        Tstat =  @(tt,y,freqs) computeT2(tt,y,freqs);
    case 'Tinf'
        Tstat =  @(tt,y,freqs) computeTinf(tt,y,freqs);
    case 'T2cent'
        Tstat =  @(tt,y,freqs) computeT2cent(tt,y,freqs);
end
TMAT1 = getPermTMAT(tt,y1,freqs,Nperm_tot,method);
TMAT2 = getPermTMAT(tt,y2,freqs,Nperm_tot,method);
TMAT3 = getPermTMAT(tt,y3,freqs,Nperm_tot,method);
Tvec1 = Tstat(tt,y4,freqs);
Tvec2 = Tstat(tt,y5,freqs);

[E_P_E_pi,Var_P_E_pi,E_P_Var_pi]=getTstatsPerm(TMAT1,TMAT2,TMAT3);
[E_P,Var_P] = getTstatsNoPerm(Tvec1,Tvec2);

lhs = E_P - E_P_E_pi;
rhs = sqrt(3*Var_P_E_pi) + sqrt(3*Var_P) + sqrt(3*E_P_Var_pi/alpha);
bnd = 1-(rhs/lhs).^2;
end