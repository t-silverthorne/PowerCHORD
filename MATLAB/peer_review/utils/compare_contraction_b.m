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
                                    tt = tt+ w(mm)*(1-kd(i,k))*(1-kd(k,alpha))*(1-kd(alpha,gamma))*(1-kd(gamma,i)).*...
                                             (1-kd(j,l))*(1-kd(l,beta))*(1-kd(beta,rho))*(1-kd(rho,j)).*...
                                             (1-kd(j,beta))*(1-kd(l,rho))*(1-kd(i,alpha))*(1-kd(k,gamma)).*...
                                             Q(i,k)*Q(alpha,gamma)*x(j)*x(l)*x(beta)*x(rho);

                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
ss
J  = ones(n,n)-eye(n);
hQ = J.*Q;
X  = x*x';
hX = J.*X;
dX = diag(x);
dQ = diag(diag(Q));
uu = ones(n,1);

tB = @(Q,hQ,dQ) 2*trace(J*dQ*J*hQ) + 3*trace(J*hQ.*hQ) + uu'*hQ*hQ*uu;

w(mm)*tB(Q,hQ,dQ)*tB(X,hX,dX)




