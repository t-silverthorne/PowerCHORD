format long
n = 5;
T = getSymm4Mask_subtypes(n);
w = getSymm4Weights_subtypes(n);
Q = randn(n,n);
Q = Q*Q';
x = rand(n,1);

ss = 0;
tt = 0;
kd = @(a,b) (a==b);
tic
for mm=1:15
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
toc
J  = ones(n,n)-eye(n);
hQ = J.*Q;
X  = x*x';
hX = J.*X;
dX = diag(diag(x*x'));
dQ = diag(diag(Q));
uu = ones(n,1);

tA  = @(M,hM)    trace(J*hM*J*hM) + trace(J*M.^2) -2*uu'*hM*hM*uu;
tB1 = @(Q,hQ,dQ) trace(J*dQ*J*hQ);
tB2 = @(Q,hQ,dQ) trace(J*hQ*hQ) ;

tC1 = @(dQ) uu'*dQ*J*dQ*uu;
tC2 = @(Q,hQ) trace(hQ*Q);

tD1 = @(Q,dQ) trace(dQ*Q*J);
tE1 = @(Q) sum(diag(Q).^2);
tic
w(1)*tA(Q,hQ)*tA(X,hX)+...
    w(2)*(2*tB1(Q,hQ,dQ)*tB1(X,hX,dX)+4*tB2(Q,hQ,dQ)*tB2(X,hX,dX))+...
    w(8)*(tC1(dQ)*tC1(dX) + 2*tC2(Q,hQ)*tC2(X,hX))+...
    w(11)*(4*tD1(Q,dQ)*tD1(X,dX))+...
    w(15)*tE1(Q)*tE1(X)
toc
ss



