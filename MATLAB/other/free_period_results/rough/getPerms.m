function Lmat = getPerms(Nmeas,Nperm,pdim,method)
%GETPERMS use Lehmer codes for fast permutation generation
arguments
    Nmeas;
    Nperm;
    pdim  = 2;
    method = 'rs-replace';
end
switch method
    case 'rs-replace'
        inds = randsample(factorial(Nmeas),Nperm,true);
    case 'rs-no-rep'
        inds = randsample(factorial(Nmeas),Nperm,false);
    case 'randi'
        inds = randi([1,factorial(Nmeas)],[1,Nperm]);
end
Lmat = idxToLehmer(inds,Nmeas);
Lmat = lehmerToPerm(Lmat);
if pdim >=3
    Lmat = rowMatToPaged(Lmat,pdim);
end
end

