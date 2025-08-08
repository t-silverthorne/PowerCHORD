function Yperm = perm5d(Y4d,Nperm,method)
%PERM5D given n x 1 x 1 x m array, generate n x1 x 1 m x Nperm
% array using permutations
arguments
    Y4d  (:,1,1,:) double;
    Nperm double;
    method = 'builtin';
end
Yperm = NaN([size(Y4d,1),size(Y4d,2),size(Y4d,3),size(Y4d,4),Nperm]);
Nmeas = size(Y4d,1);
Nsamp = size(Y4d,4);
for ii=1:Nsamp
    yloc              = Y4d(:,:,:,ii);
    switch method
        case 'builtin'
            for jj=1:Nperm
                Yperm(:,:,:,ii,jj) = yloc(randperm(Nmeas));
            end
        case 'lehmer'
            Ploc              = getPerms(Nmeas,Nperm,5);
            Yperm(:,:,:,ii,:) = yloc(Ploc);
    end
end
end

