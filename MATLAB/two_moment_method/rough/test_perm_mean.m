% test exact formula for mean of quad form over permutation group
n = 5;
L = randn(n)/n;
L = L*L';
f = @(x) x'*L*x;

Sigma = randn(n)/n;
Sigma = Sigma*Sigma';
mu    = 1+randn(n,1);

w1 = factorial(n-1)/factorial(n); w2 = factorial(n-2)/factorial(n);

J = ones(n,n) - eye(n);

mm1 = trace(Sigma)+mu'*mu; % moments under mvn distribution
mm2 = trace(Sigma*J)+mu'*J*mu;


% monte carlo calculation
nsamp = 1e5;
X     = mvnrnd(mu,Sigma,nsamp)';
X     = reshape(X,n,1,[]);

pp   = perms(1:n);
svec = NaN(nsamp,1);
for ii=1:nsamp
    qq = 0;
    x  = X(:,:,ii);
    for jj=1:factorial(n)
        qq = qq+f(x(pp(jj,:)));
    end
    svec(ii) = qq;
end
v_exact  = mm1*trace(L)*w1 + w2*trace(J*L)*mm2 % exact calculation
v_approx = mean(svec)/factorial(n)
