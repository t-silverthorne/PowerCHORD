clear
addpath('../')
n     = 35;
n5    = 3;
n6    = 3;
L     = 2*randn(n,n);
L     = L*L';
mu    = 10+randn(n,1);
[~,T] = getSymm4Mask_subtypes(n);

Sigma = rand(n,n);
Sigma = Sigma*Sigma';
MUs = cell(n5,n6);
for ii=1:n5
    for jj=1:n6
        MUs{ii,jj} = rand(n,1);
    end
end

% serial compute
res_cell = cell(n5,n6);
tic
for ii=1:n5
    for jj=1:n6
        bnd_cell{ii,jj}=get2mBound(L,Sigma,MUs{ii,jj},.05,T);
    end
end
toc

muVECT = zeros(n,1,1,1,n5,n6);
for ii=1:n5
    for jj=1:n6
        muVECT(:,1,1,1,ii,jj) = MUs{ii,jj};
    end
end
[A1,A2,A3,B1,B2,B3] = getIsserlisTensor_Sigma_Vect(Sigma);

tic
bvect = getExactMomentsVect(L,Sigma,muVECT,T,A1,A2,A3,B1,B2,B3);
toc

bb=true;
for ii=1:n5
    for jj=1:n6
        bb = bb&(abs(bvect(:,:,:,:,ii,jj)-bnd_cell{ii,jj})/bnd_cell{ii,jj} < 1e-10);
    end
end
bb