% contract permutation against Gaussian integral to compute
%       E_pi E_P (x^t A x)^2

% exact computation
n = 4;
%rng('default')
A = full(sprandsym(n,.5));
A = A*A'*1;
%A = eye(n);%blkdiag(eye(2),0*eye(2));

mu = 0*randn(n,1);
C  = randn(n,n);
C  = chol(C*C');
C  = C*C'/1;
%C  = eye(n);
G    = getIsserlisTensor(C,mu);
A34  = reshape(A,[1,1,n,n]);
G    = (A~=0).*G.*(A34~=0);

M                = zeros(n,n,n,n);
[Ta,Tb,Tc,Td,Te] = getSymm4Mask(n);
[wa,wb,wc,wd,we] = getSymm4Weights(n);

M(Ta) = sum(G(Ta))*wa;
M(Tb) = sum(G(Tb))*wb;
M(Tc) = sum(G(Tc))*wc;
M(Td) = sum(G(Td))*wd;
M(Te) = sum(G(Te))*we;

%temp = A.*M.*A34
v1=sum(A.*M.*A34,'all')%sum(temp,'all')

v1b=0; % check contraction is correct
for ii=1:n
    for jj=1:n
        for kk=1:n
            for ll=1:n
                v1b = v1b + A(ii,jj)*A(kk,ll)*M(ii,jj,kk,ll);
            end
        end
    end
end
v1b
% 
% A34  = reshape(A,[1,1,n,n]);
% temp = tensorprod(M,A34,[3,4]);
% A(:)'*temp(:)


nsamp = 1e5;
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
v2=mean(svec)/factorial(n);


v2/v1
