% fast vs slow without mean
n = 20;
C = full(sprandsym(n,.4));
C = C*C';
mu = zeros(n,1);
M1 = getIsserlisTensor(C,mu,'tensor');
M2 = getIsserlisTensor(C,mu,'loop');
max(abs(M1-M2),[],'all')

%% fast vs slow with mean
n = 100;
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


% fast vs sim with mean
nsamp = 1e7;
X=mvnrnd(mu,C,nsamp);
i1=randsample(1:n,1);i2=randsample(1:n,1);i3=randsample(1:n,1);i4=randsample(1:n,1);
mean(X(:,i1).*X(:,i2).*X(:,i3).*X(:,i4))
M1(i1,i2,i3,i4)

M2(i1,i2,i3,i4)