% contract permutation against Gaussian integral to compute
%       E_pi E_P (x^t A x)^2

% exact computation
n = 4;
%rng('default')
A = full(sprandsym(n,.55));
A = A*A'*1;

mu = 10+randn(n,1);
C  = randn(n,n);
C  = chol(C*C');
C  = C*C'/10;
G  = getIsserlisTensor(C,mu);

M                = zeros(n,n,n,n);
[Ta,Tb,Tc,Td,Te] = getSymm4Mask(n);
[wa,wb,wc,wd,we] = getSymm4Weights(n);

M(Ta) = sum(G(Ta))*wa;
M(Tb) = sum(G(Tb))*wb;
M(Tc) = sum(G(Tc))*wc;
M(Td) = sum(G(Td))*wd;
M(Te) = sum(G(Te))*we;

A34  = reshape(A,[1,1,n,n]);
temp = tensorprod(M,A34,[3,4]);
v1=A(:)'*temp(:);

% v1b=0; % check contraction is correct
% for ii=1:n
%     for jj=1:n
%         for kk=1:n
%             for ll=1:n
%                 v1b = v1b + A(ii,jj)*A(kk,ll)*M(ii,jj,kk,ll);
%             end
%         end
%     end
% end
% v1b

%%
% explicit sum
nsamp = 1e6;
X     = mvnrnd(mu,C,nsamp)';
X     = reshape(X,n,1,[]);

pp = perms(1:n);
svec = NaN(nsamp,1);
f = @(x) (x'*A*x)^2;
for ii=1:nsamp
    qq = 0;
    x = X(:,:,ii);
    for jj=1:factorial(n)
        qq = qq+f(x(pp(jj,:)));
    end
    svec(ii) = qq/factorial(n);
end
v2=mean(svec);
v1/v2




