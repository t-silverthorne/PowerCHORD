function Lmat = getPerms(Nmeas,Nperm,pdim)
%GETPERMS use Lehmer codes for fast permutation generation
arguments
    Nmeas;
    Nperm;
    pdim  = 2;
end
inds = randsample(factorial(Nmeas),Nperm);
Lmat = idxToLehmer(inds,Nmeas);
Lmat = lehmerToPerm(Lmat);
if pdim >=3
    Lmat = rowMatToPaged(Lmat,pdim);
end
end

