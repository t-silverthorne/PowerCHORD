function [m10,m11,m21,m20,m12]=getExactMomentsGPU(L,Sigma,mu,T)
% given quadratic form T(x) = x^t A x, compute the following moments
%   moment:              idx
%    E_P T               1 0
%    E_P E_pi T          1 1
%    E_P(E_pi T)^2       2 1
%    E_P T^2             2 0
%    E_P E_pi (T^2)      1 2
arguments
    L     (:,:) double; % should all be gpuArrays
    Sigma (:,:) double;
    mu    (:,1) double;
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
G = gpuArray(getIsserlisTensor(Sigma,mu));

% compute m10
m10 = trace(L*Sigma)+mu'*L*mu;


% compute m11
w1  = factorial(n-1)/factorial(n);
w2  = factorial(n-2)/factorial(n);
J   = ones(n,n) - eye(n);
J   = gpuArray(J);
tt1 = trace(Sigma)+mu'*mu; % moments under mvn distribution
tt2 = trace(Sigma*J)+mu'*J*mu;
m11 = tt1*trace(L)*w1 + tt2*trace(J*L)*w2;

% compute m21
q2form = @(A,B) sum(A.*G.*reshape(B,[1,1,n,n]),'all');
Ig  = gpuArray(eye(n));
vv1 = q2form(Ig,Ig);
vv2 = q2form(J,J);
vv3 = q2form(Ig,J);


% compute m20
L34 = reshape(L,[1,1,n,n]);
m20 = sum(L.*G.*L34,'all');


% compute m12
M = gpuArray(zeros(n,n,n,n));
w = getSymm4Weights_subtypes(n);
switch Tmeth
    case 'tensor'
        for ii=1:15
            M(T(:,:,:,:,ii)) = sum(G(T(:,:,:,:,ii)))*w(ii);
        end
    case 'linear'
        for ii=1:15
            M(T(:,ii)) = sum(G(T(:,ii)))*w(ii);
        end        
end

m12 = sum(L.*M.*L34,'all') ;
end
