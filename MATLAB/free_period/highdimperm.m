Nmeas = 8;
Nsamp = 5;
Nperm = 3;
y = randn(Nmeas,1,1,Nsamp);

Yperm = NaN([size(y),Nperm]);
for ii=1:Nsamp
    yloc              = y(:,:,:,ii);
    Ploc              = getPerms(Nmeas,Nperm,5);
    Yperm(:,:,:,ii,:) = yloc(Ploc);
end

id_check = randsample(1:Nsamp,1);
sum(y(:,:,:,id_check))
sum(Yperm(:,:,:,id_check,:),1)