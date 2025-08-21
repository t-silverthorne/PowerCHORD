addpath('../')
% compare vect vs non vect versions of Isserlis computation
clear
n = 5;
% not vectorized
C1  = rand(n,n);
C2  = rand(n,n);
C3  = rand(n,n);
mu1 = rand(n,1);
mu2 = rand(n,1);
mu3 = rand(n,1);
G1=getIsserlisTensor(C1,mu1,'loop');
G2=getIsserlisTensor(C2,mu2,'loop');
G3=getIsserlisTensor(C3,mu3,'loop');

% vectorized
muVECT = zeros(n,1,1,1,3,1);
CVECT  = zeros(n,n,1,1,3,1);

muVECT(:,1,1,1,1,1) = mu1;
muVECT(:,1,1,1,2,1) = mu2;
muVECT(:,1,1,1,3,1) = mu3;

CVECT(:,:,1,1,1,1) = C1;
CVECT(:,:,1,1,2,1) = C2;
CVECT(:,:,1,1,3,1) = C3;
Gv = getIsserlisTensorVect(CVECT,muVECT)

all(Gv(:,:,:,:,1)==G1,'all')
all(Gv(:,:,:,:,2)==G2,'all')
all(Gv(:,:,:,:,3)==G3,'all')