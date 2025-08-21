clear
n  = 10;
n5 = 10;
n6 = 10;

% setup
Cs  = cell(n5,n6);
MUs = cell(n5,n6);
for ii=1:n5
    for jj=1:n6
        Cloc = randn(n,n);
        Cloc = Cloc*Cloc';
        Cs{ii,jj} = Cloc;
        MUs{ii,jj} = rand(n,1);
    end
end

% serial compute
w = getSymm4Weights_subtypes(n);
[~,T] = getSymm4Mask_subtypes(n);
Mcell = cell(n5,n6);
tic;
for kk=1:n5
    for ll=1:n6
        G = getIsserlisTensor(Cs{kk,ll},MUs{kk,ll}); 
        M = zeros(n,n,n,n);
        for ii=1:15
            M(T(:,ii)) = sum(G(T(:,ii)))*w(ii);
        end        
        Mcell{kk,ll} = M;
    end
end
toc

% likely the fastest way
muVECT = zeros(n,1,1,1,n5,n6);
CVECT  = zeros(n,n,1,1,n5,n6);
for ii=1:n5
    for jj=1:n6
        muVECT(:,1,1,1,ii,jj) = MUs{ii,jj};
        CVECT(:,:,1,1,ii,jj)  = Cs{ii,jj};
    end
end
[A1,A2,A3,B1,B2,B3] = getIsserlisTensor_Sigma_Vect(CVECT);
Gv = getIsserlisTensor_mu_Vect(muVECT,A1,A2,A3,B1,B2,B3);
Mcell2 = cell(n5,n6);
tic;
for kk=1:n5
    for ll=1:n6
        G = Gv(:,:,:,:,kk,ll); 
        M = zeros(n,n,n,n);
        for ii=1:15
            M(T(:,ii)) = sum(G(T(:,ii)))*w(ii);
        end        
        Mcell2{kk,ll} = M;
    end
end
toc



Tv = getSymm4Mask_subtypesVect(n,n5,n6);
Mv = zeros(n,n,n,n,n5,n6);
sz = [n,n,n,n,n5,n6];

bb=true;
for ii=1:n5
    for jj=1:n6
        bb = bb&all(abs(Mcell2{ii,jj}-Mcell{ii,jj})./abs(Mcell{ii,jj})<1e-10,'all');
    end
end
bb


