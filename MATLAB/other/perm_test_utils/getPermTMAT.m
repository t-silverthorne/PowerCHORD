function TMAT =getPermTMAT(tt,y,freqs,Nperm_tot,method)
switch method
    case 'T2'
        Tstat =  @(tt,y,freqs) computeT2(tt,y,freqs);
    case 'Tinf'
        Tstat =  @(tt,y,freqs) computeTinf(tt,y,freqs);
    case 'T2cent'
        Tstat =  @(tt,y,freqs) computeT2cent(tt,y,freqs);
end
n    = length(tt);
Nbatch = 1; 
Nperm  = Nperm_tot;
TMAT   = NaN(size(y,2),Nperm);
for bb=1:Nbatch
[~,perms]=sort(rand(n,size(y,2),Nperm),1);
    for pp=1:Nperm
        yp=y;
        for jj=1:size(y,2)
            yp(:,jj) = yp(perms(:,jj,pp),jj);
        end
        TMAT(:,pp) = Tstat(tt,yp,freqs);
    end
end
end