rng('default')
%%
example = 'generic';
n   = 4;
switch example
    case 'simple'
        A = eye(n);
        C = eye(n);
        mu = zeros(n,1);
    case 'generic'
        A = full(sprandsym(n,.5)); % quad form 
        A = A*A';
        C  = randn(n,n);
        C  = chol(C*C');
        C  = C*C';
        mu = 1+randn(n,1);
end

A34 = reshape(A,[1,1,n,n]);

G   = getIsserlisTensor(C,mu); % matrix of 4th moments

T = getSymm4Mask_subtypes(n);
w = getSymm4Weights_subtypes(n);
M = zeros(n,n,n,n);
for ii=1:15
    M(T(:,:,:,:,ii)) = sum(G(T(:,:,:,:,ii)))*w(ii);
end

v1 = sum(A.*M.*A34,'all') ;
%%
tic
switch example
    case 'simple'
       v1 == n^2+2*n    
    case 'generic'
        nsamp = 1e6;
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
        (v1-v2)/v1
end
toc