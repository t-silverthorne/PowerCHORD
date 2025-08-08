function Lmat = getPerms(Nmeas,Nperm,pdim,replace)
%GETPERMS use Lehmer codes for fast permutation generation
arguments
    Nmeas;
    Nperm;
    pdim  = 2;
    replace = true;
end
inds = randsample(factorial(Nmeas),Nperm,replace);
Lmat = idxToLehmer(inds,Nmeas);
Lmat = lehmerToPerm(Lmat);
if pdim >=3
    Lmat = rowMatToPaged(Lmat,pdim);
end
end

