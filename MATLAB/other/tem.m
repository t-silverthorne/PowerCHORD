% checking unitary phase property
n = 3;
tt = linspace(0,1,n+1);%rand(n,1);
tt = tt(1:end-1)';
X = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
X'*X/n

delta = rand;
ss = tt + delta;

Xs = [ones(n,1) cos(2*pi*ss) sin(2*pi*ss)];

U = @(delta) blkdiag(1,[cos(2*pi*delta) sin(2*pi*delta);-sin(2*pi*delta) cos(2*pi*delta)]);
Uneg = U(-delta)
U    = U(delta);
Xs
U'*X'*X*U

Xs'*Xs

inv(Xs'*Xs)
Uneg*inv(X'*X)*Uneg'
%%
H = [0 1 0; 0 0 1]
beta = rand(2,1);
U*H'*beta

H'*U(2:3,2:3)*beta

%% checking trig polynomial at roots of unity
n  = 8;
nt = 3;
th = linspace(0,2*pi,n+1); % nth roots of unity
th = th(1:end-1)
avec = rand(nt,1) + 1j*rand(nt,1);
bvec = rand(nt,1) + 1j*rand(nt,1);
kv1  = randsample(1:n,nt,false);
kv2  = randsample(1:n,nt,false);

avecexp()
avec

sum(exp(1j*th).*exp(-1j*th))/n

exp(1j*sum(th-th'))
