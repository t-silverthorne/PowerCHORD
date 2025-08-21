function [m10,m11,m21,m20,m12]=getExactMomentsVect(L,Sigma,mu,Tlin,A1,A2,A3,B1,B2,B3)
% vectorization is only wrt mu
% given quadratic form T(x) = x^t A x, compute the following moments
%   moment:              idx
%    E_P T               1 0
%    E_P E_pi T          1 1
%    E_P(E_pi T)^2       2 1
%    E_P T^2             2 0
%    E_P E_pi (T^2)      1 2
arguments
    L     (:,:) double;
    Sigma (:,:) double;
    mu    (:,1,1,1,:,:) double;
    Tlin  (:,15) logical;
    A1  (:,:,:,:,:,:) double;
    A2  (:,:,:,:,:,:) double;
    A3  (:,:,:,:,:,:) double;
    B1  (:,:,:,:,:,:) double;
    B2  (:,:,:,:,:,:) double;  
    B3  (:,:,:,:,:,:) double;
end

% pre-compute Gaussian moments
n  = size(L,1);
n5 = size(mu,5);
n6 = size(mu,6);

G                   = getIsserlisTensor_mu_Vect(mu,A1,A2,A3,B1,B2,B3);

% compute m10
m10 = trace(L*Sigma)+pagemtimes(pagetranspose(mu),pagemtimes(L,mu));

% compute m11
w1  = factorial(n-1)/factorial(n);
w2  = factorial(n-2)/factorial(n);
J   = ones(n,n) - eye(n);
tt1 = trace(Sigma)+pagemtimes(pagetranspose(mu),mu); % moments under mvn distribution
tt2 = trace(Sigma*J)+pagemtimes(pagetranspose(mu),pagemtimes(J,mu));
m11 = tt1*trace(L)*w1 + tt2*trace(J*L)*w2;

% compute m21
q2form = @(A,B) sum(A.*G.*reshape(B,[1,1,n,n]),[1,2,3,4]);
vv1 = q2form(eye(n),eye(n));
vv2 = q2form(J,J);
vv3 = q2form(eye(n),J);

m21 = vv1*(trace(L)*w1)^2 + vv2*(trace(L*J)*w2)^2 + ...
    2*vv3*(w1*w2*trace(L)*trace(L*J));

% compute m20
L34 = reshape(L,[1,1,n,n]);
m20 = sum(L.*G.*L34,[1,2,3,4]);

% compute m12 (nested loop appears to be fastest)
M = zeros(n,n,n,n);
w = getSymm4Weights_subtypes(n);
M = zeros(n,n,n,n,n5,n6);
for kk=1:n5
    for ll=1:n6
        Gloc = G(:,:,:,:,kk,ll); 
        Mloc = zeros(n,n,n,n);
        for ii=1:15
            Mloc(Tlin(:,ii)) = sum(Gloc(Tlin(:,ii)))*w(ii);
        end        
        M(:,:,:,:,kk,ll) = Mloc;
    end
end
m12 = sum(L.*M.*L34,[1,2,3,4]) ;
end

