n = 4;
T = getSymm4Mask_subtypes(n);
w = getSymm4Weights_subtypes(n);
Q = randn(n,n);
Q = Q*Q';
x = rand(n,1);

ss = 0;
tt = 0;
kd = @(a,b) (a==b)
kd(1,1)

for mm=2:7
    for i=1:n
        for k=1:n
            for alpha=1:n
                for gamma=1:n
                    for j=1:n
                        for l=1:n
                            for beta=1:n
                                for rho=1:n
                                    ss = ss + w(mm)*T(i,k,alpha,gamma,mm)*T(j,l,beta,rho,mm)*...
                                        Q(i,k)*Q(alpha,gamma)*x(j)*x(l)*x(beta)*x(rho);
                                    % tt = tt+ w(mm)*kd(i,k)*J(k,alpha)*J(k,gamma)*J(alpha,gamma)*...
                                    % Q(i,k)*Q(alpha,gamma)*x(j)*x(l)*x(beta)*x(rho)*...
                                    % kd(j,l)*J(l,beta)*J(beta,rho)*J(l,rho);

                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% tt
J  = ones(n,n)-eye(n);
hQ = J.*Q;
X  = x*x';
hX = J.*X;
dX = diag(diag(x*x'));
dQ = diag(diag(Q));
uu = ones(n,1);

tB1 = @(Q,hQ,dQ) trace(J*dQ*J*hQ);% + uu'*hQ*hQ*uu;
tB2 = @(Q,hQ,dQ) trace(J*hQ*hQ) ;% + uu'*hQ*hQ*uu;
w(mm)*(2*tB1(Q,hQ,dQ)*tB1(X,hX,dX)+4*tB2(Q,hQ,dQ)*tB2(X,hX,dX)) %+tB5(hQ)*tB5(hX))
ss





