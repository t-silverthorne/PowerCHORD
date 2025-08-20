function [m10,m11,m21,m20,m12]=getExactMomentsVect(L,Sigma,mu,T)
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
    T     logical;
end

if length(size(T))==5
    Tmeth = 'tensor';
elseif length(size(T)) ==2 && size(T,2)==15
    Tmeth = 'linear';
else
    error('permutation tensor T of wrong shape')
end

n = size(L,1);
G = getIsserlisTensorVect(Sigma,mu); 
% compute m10
m10 = trace(L*Sigma)+pagemtimes(pagetranspose(mu),pagemtimes(L,mu));

% compute m11
w1  = factorial(n-1)/factorial(n);
w2  = factorial(n-2)/factorial(n);
J   = ones(n,n) - eye(n);
tt1 = trace(Sigma)+pagemtimes(pagetranspose(mu),mu); % moments under mvn distribution
tt2 = trace(Sigma*J)+pagemtimes(pagetranspose(mu),pagemtimes(J,mu));
m11 = tt1*trace(L)*w1 + tt2*trace(J*L)*w2;

% compute m20
L34 = reshape(L,[1,1,n,n]);
m20 = sum(L.*G.*L34,[1,2,3,4]);


