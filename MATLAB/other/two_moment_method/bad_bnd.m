n =20;
tt=linspace(0,1,n);

fvals = [1 1.25 2 5 10];
ff = @(cc) getBND(cc,tt,fvals)

min(arrayfun(@(cc) ff(cc),1:100))
function bnd =getBND(cc,tt,fvals)
lmaxf = @(fvals) arrayfun(@(f)max(eig(getSpecQform(tt,f))),fvals);
lminf = @(fvals) arrayfun(@(f)max2(eig(getSpecQform(tt,f))),fvals);
num   = log(sum(exp(cc*lmaxf(fvals))));
den   = cc*max(lminf(fvals));

bnd = num/den;
end
function mm = max2(aa)
mm = max(aa(aa<max(aa)));
end