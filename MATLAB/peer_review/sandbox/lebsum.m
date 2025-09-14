% homoscedastic comparison
n  = 12;
tt = (0:n-1)'/n;
X = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];

X'*X/n
syms tt
Xsym = [1 cos(2*pi*tt) sin(2*pi*tt)];
int(Xsym'*Xsym,tt,0,1)

% heteroscedastic comparison
tt = (0:n-1)'/n;
phin = rand*2*pi;
Sigma = cos(2*pi*tt-phin).*eye(n)
X'*Sigma*X

Xsym = @(tnow) [1 cos(2*pi*tnow) sin(2*pi*tnow)];
Ssym = @(tnow) cos(2*pi*tnow-phin);
myfun = @(tt) Xsym(tt)'*Xsym(tt)*Ssym(tt);
integral(@(tt) myfun(tt),0,1,"ArrayValued",true)
%int(Xsym'*Xsym,tt,0,1)
