function  [E_p,E_p_E_pi,E_p_Var_pi,Var_p,Var_p_E_pi]  = getmcCenteredMoments(L,Sigma,mu,nsamp)
%GETMCCENTEREDMOMENTS Summary of this function goes here
%   Detailed explanation goes here
n = size(L,1);
X = mvnrnd(mu,Sigma,nsamp)';
X = reshape(X,n,1,[]);

pp = perms(1:n);


E_p_Var_pi = 0;
T  = @(x) (x'*L*x);
for ii=1:nsamp
    x   = X(:,:,ii);
    vv  = NaN(factorial(n),1);
    for jj=1:factorial(n)
        vv(jj) = T(x(pp(jj,:)));
    end
    E_p_Var_pi =E_p_Var_pi +mean(vv.^2)-mean(vv).^2;
end
E_p_Var_pi = E_p_Var_pi/nsamp;

vv = NaN(n,1);
for ii=1:nsamp
    vv(ii) = T(X(:,:,ii));
end
Var_p = var(vv);
E_p   = mean(vv);

vv = NaN(n,1);
for ii=1:nsamp
    x   = X(:,:,ii);
    qq  = NaN(factorial(n),1);
    for jj=1:factorial(n)
        qq(jj) = T(x(pp(jj,:)));
    end
    vv(ii) = mean(qq);
end
E_p_E_pi = mean(vv);
Var_p_E_pi = var(vv);
end

