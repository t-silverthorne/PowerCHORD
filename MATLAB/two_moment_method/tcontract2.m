n = 4;
%A = full(sprandsym(n,.5)); % quad form 
%A = A*A';
A = eye(n);
A34  = reshape(A,[1,1,n,n]);

mu = 0*randn(n,1); % mean and cov mat
% C  = randn(n,n);
% C  = chol(C*C');
% C  = C*C';
C  = eye(n);

G    = getIsserlisTensor(C,mu); % matrix of 4th moments

M                = zeros(n,n,n,n);
[Ta,Tb,Tc,Td,Te] = getSymm4Mask(n);
[wa,wb,wc,wd,we] = getSymm4Weights(n);

M(Ta) = sum(G(Ta))*wa;
M(Tb) = sum(G(Tb))*wb;
M(Tc) = sum(G(Tc))*wc;
M(Td) = sum(G(Td))*wd;
M(Te) = sum(G(Te))*we;

v1=sum(A.*M.*A34,'all')
%%
nsamp = 1e3;
X     = mvnrnd(mu,C,nsamp)';
X     = reshape(X,n,1,[]);

pp   = perms(1:n);
svec = NaN(nsamp,1);
f = @(x) (x'*A*x).^2;
for ii=1:nsamp
    qq = 0;
    x  = X(:,:,ii);
    for jj=1:factorial(n)
        qq = qq+f(x(pp(jj,:)));
    end
    svec(ii) = qq;
end
v2=mean(svec)/factorial(n)
