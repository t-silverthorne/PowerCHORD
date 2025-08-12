n = 4;
C = full(sprandsym(n,1));
C = C*C';
%C = eye(n);
mu = randn(n,1);
G  = getIsserlisTensor(C,mu,'tensor');
nsamp = 1e6;
X=mvnrnd(mu,C,nsamp);
G_approx = NaN(n,n,n,n);
for i1=1:n
    for i2=1:n
        for i3=1:n
            for i4=1:n
                G_approx(i1,i2,i3,i4)=...
                    mean(X(:,i1).*X(:,i2).*X(:,i3).*X(:,i4));
            end
        end
    end
end

max(abs(G(:)-G_approx(:))./G_approx(:))