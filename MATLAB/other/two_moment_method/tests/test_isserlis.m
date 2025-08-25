addpath('../')
% fast vs slow without mean
n = 4;
C = full(sprandsym(n,.4));
C = C*C';
C = eye(n);
mu = zeros(n,1);
M1 = getIsserlisTensor(C,mu,'tensor');
M2 = getIsserlisTensor(C,mu,'loop');
max(abs(M1-M2),[],'all')

%% fast vs slow with mean
n = 4;
C = full(sprandsym(n,.4));
C = C*C';
mu = 3*randn(n,1);
tic
M1 = getIsserlisTensor(C,mu,'tensor');
toc

tic
M2 = getIsserlisTensor(C,mu,'loop');
toc
%%
max(abs(M1-M2),[],'all')


%% fast vs sim with mean
n = 4;
C = full(sprandsym(n,.4));
C = C*C';
C = eye(n);
mu = zeros(n,1);
M1 = getIsserlisTensor(C,mu,'tensor');
nsamp = 1e4;
X=mvnrnd(mu,C,nsamp);
i1=randsample(1:n,1);i2=randsample(1:n,1);i3=randsample(1:n,1);i4=randsample(1:n,1);
mean(X(:,1).*X(:,2).*X(:,1).*X(:,1))
%%
sum(M1,'all')