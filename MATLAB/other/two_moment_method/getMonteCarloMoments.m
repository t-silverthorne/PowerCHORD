function [m10,m11,m21,m20,m12] = getMonteCarloMoments(L,Sigma,mu,nsamp)
%GETMONTECAR Summary of this function goes here
%   Detailed explanation goes here
arguments
    L     (:,:) double;
    Sigma (:,:) double;
    mu    (:,1) double;
    nsamp double;
end
n = size(L,1);
X = mvnrnd(mu,Sigma,nsamp)';
X = reshape(X,n,1,[]);

n = size(L,1);

pp = perms(1:n);
T  = @(x) (x'*L*x);
m10=0;m11=0;m21=0;m20=0;m12=0;
for ii=1:nsamp
    x   = X(:,:,ii);
    m10 = m10+T(x);
    q11 = 0;
    m20 = m20+T(x).^2;
    q12 = 0;
    for jj=1:factorial(n)
        xp = x(pp(jj,:));
        q11 = q11+T(xp);
        q12 = q12+T(xp)^2;
    end
    m11 = m11 +  q11/factorial(n);
    m21 = m21 + (q11/factorial(n)).^2;
    m12 = m12 + q12/factorial(n);
end

m10 = m10/nsamp;
m11 = m11/nsamp;
m21 = m21/nsamp;
m20 = m20/nsamp;
m12 = m12/nsamp;
end
