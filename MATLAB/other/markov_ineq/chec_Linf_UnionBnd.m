n = 9;
J = ones(n,n)-eye(n);
th = rand(n,1);
X = [ones(n,1) cos(th) sin(th)]
H = [0 1 0; 0 0 1];
C = H*((X'*X)\(X'));
eig(C'*C)
eig(J*(C'*C))
%%
syms a b c1 c2
eig([-a 0; a*c1 -b*c2])

%%

eig(J*A)
%%

%%
sum(eig(A))
%%
sum(abs(eig(A).^2)/sqrt(n))