addpath('../')
clear
n  = 48;
n5 = 4;
n6 = 4;

Cs  = cell(n5,n6);
MUs = cell(n5,n6);
Gs  = cell(n5,n6);

% serial computation
for ii=1:n5
    for jj=1:n6
        Cloc = rand(n,n);
        Cloc = Cloc*Cloc';
        Cs{ii,jj} = Cloc;
        MUs{ii,jj} = rand(n,1);
    end
end


tic
for ii=1:n5
    for jj=1:n6
        Gs{ii,jj} = getIsserlisTensor(Cs{ii,jj},MUs{ii,jj},'tensor');
    end
end
toc

muVECT = zeros(n,1,1,1,n5,n6);
CVECT  = zeros(n,n,1,1,n5,n6);
% vectorized computation

for ii=1:n5
    for jj=1:n6
        muVECT(:,1,1,1,ii,jj) = MUs{ii,jj};
        CVECT(:,:,1,1,ii,jj)  = Cs{ii,jj};
    end
end
[A1,A2,A3,B1,B2,B3] = getIsserlisTensor_Sigma_Vect(CVECT);
tic; Gv = getIsserlisTensor_mu_Vect(muVECT,A1,A2,A3,B1,B2,B3);toc

bb=true;
for ii=1:n5
    for jj=1:n6
        bb = bb&all(Gv(:,:,:,:,ii,jj)==Gs{ii,jj},'all');
    end
end
bb