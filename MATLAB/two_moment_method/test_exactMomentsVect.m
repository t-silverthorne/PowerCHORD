% check that vectorised moment calculation matches serial
clear
n     = 8;
n5    = 20;
n6    = 20;
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
        [m10,m11,m21,m20,m12]=getExactMoments(L,Sigma,MUs{ii,jj},T);
        res_cell{ii,jj} = [m10,m11,m21,m20,m12];
    end
end
toc

%vect compute
muVECT = zeros(n,1,1,1,n5,n6);
for ii=1:n5
    for jj=1:n6
        muVECT(:,1,1,1,ii,jj) = MUs{ii,jj};
    end
end
[A1,A2,A3,B1,B2,B3] = getIsserlisTensor_Sigma_Vect(Sigma);
tic
[mvect1,mvect2,mvect3,mvect4,mvect5] = getExactMomentsVect(L,Sigma,muVECT,T,A1,A2,A3,B1,B2,B3);
toc


bb=true;
for ii=1:n5
    for jj=1:n6
        vres = [mvect1(:,:,:,:,ii,jj),mvect2(:,:,:,:,ii,jj),mvect3(:,:,:,:,ii,jj),...
            mvect4(:,:,:,:,ii,jj),mvect5(:,:,:,:,ii,jj)];
        bb = bb&all(abs(res_cell{ii,jj}-vres)./abs(res_cell{ii,jj})<1e-10,'all');
    end
end
bb