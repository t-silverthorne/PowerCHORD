n=4;
I = eye(n);
pp = perms(1:n);

i=1;
k=1;
alpha=2;
gamma=2;
j = 1;
l = 2;
beta = 1;
rho =2;

ss = 0;
for jj=1:factorial(n)
    pmat = I(:,pp(jj,:));
    ss = ss+ pmat(i,j)*pmat(k,l)*pmat(alpha,beta)*pmat(gamma,rho);
end
ss

n  = 5;
A  = 1*randn(n,n);
tt = rand(n,1);
X  = [ones(n,1) 5*cos(2*pi*tt) 5*sin(2*pi*tt)];
H  = [0 0 1; 0 1 0];
A  = H*((X'*X)\(X'));
A  = A'*A;

I  = eye(n);
pp = perms(1:n);

Api = 0 
for jj=1:factorial(n)
    pmat = I(:,pp(jj,:));
    Api = Api + pmat'*A*pmat;
end
Api=Api/factorial(n);

eig(A-Api)
