% generate Isserlis tensor
n   = 4;
Q   = randn(n,n);
Q   = Q*Q';
G4  = NaN(n,n,n,n);
Sig = randn(n,n); Sig=Sig*Sig;
mu  = randn(n,1);
G = Sig + mu*mu';
for i=1:n
    for j=1:n
        for k=1:n
            for l=1:n
                G4(i,j,k,l) = G(i,j)*G(k,l) + G(i,k)*G(j,l)+G(i,l)*G(k,j);
            end
        end
    end
end

% exact evaluation
T = getSymm4Mask_subtypes(n);
w = getSymm4Weights_subtypes(n);

mmin=15;
mmax=15;
ss = 0;
tic;
for mm=15:15
    for i=1:n
        for k=1:n
            for alpha=1:n
                for gamma=1:n
                    for j=1:n
                        for l=1:n
                            for beta=1:n
                                for rho=1:n
                                    ss = ss + w(mm)*T(i,k,alpha,gamma,mm)*T(j,l,beta,rho,mm)*...
                                        Q(i,k)*Q(alpha,gamma)*G4(j,l,beta,rho);
        
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
ss

