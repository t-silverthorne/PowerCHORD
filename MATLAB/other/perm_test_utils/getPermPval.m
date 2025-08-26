function pval =getPermPval(tt,y,freqs,Nperm_tot,method)
switch method
    case 'T2'
        Tstat =  @(tt,y,freqs) computeT2(tt,y,freqs);
    case 'Tinf'
        Tstat =  @(tt,y,freqs) computeTinf(tt,y,freqs);
    case 'T2cent'
        Tstat =  @(tt,y,freqs) computeT2cent(tt,y,freqs);
end
Tobs = Tstat(tt,y,freqs);
n    = length(tt);
cnt  = 0;
Nbatch = 1; %want Nfreqs*size(y,2)*Nperm < memcut
Nperm  = Nperm_tot;%floor(Nperm_tot/Nbatch);
for bb=1:Nbatch
[~,perms]=sort(rand(n,size(y,2),Nperm),1);
    for pp=1:Nperm
        yp=y;
        for jj=1:size(y,2)
            yp(:,jj) = yp(perms(:,jj,pp),jj);
        end
        Tperm = Tstat(tt,yp,freqs);
        cnt   = cnt + (Tperm>Tobs);
    end
end
pval = cnt/Nperm/Nbatch;
end