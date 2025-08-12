function [m10,m11,m21,m20,m12]=getExactMoments(L,Sigma,mu)
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
    mu    (:,1) double;
end

n = size(L,1);
G = getIsserlisTensor(Sigma,mu); % matrix of 4th moments

% compute m10
m10 = trace(L*Sigma)+mu'*L*mu;

% compute m11
w1  = factorial(n-1)/factorial(n);
w2  = factorial(n-2)/factorial(n);
J   = ones(n,n) - eye(n);
tt1 = trace(Sigma)+mu'*mu; % moments under mvn distribution
tt2 = trace(Sigma*J)+mu'*J*mu;
m11 = tt1*trace(L)*w1 + tt2*trace(J*L)*w2;

% compute m21
q2form = @(A,B) sum(A.*G.*reshape(B,[1,1,n,n]),'all');
vv1 = q2form(eye(n),eye(n));
vv2 = q2form(J,J);
vv3 = q2form(eye(n),J);

% vv1=0;
% for ii=1:n
%     for jj=1:n
%         vv1 = vv1+G(ii,ii,jj,jj);
%     end
% end
% J34 = reshape(J,[1,1,n,n]);
% vv2 = sum(J.*G.*J34,'all');
% vv3 = 0;
% for ii=1:n
%     vv3 = sum(J.*G(:,:,ii,ii),'all');
% end
m21 = vv1*(trace(L)*w1)^2 + vv2*(trace(L*J)*w2)^2 + ...
    2*vv3*(w1*w2*trace(L)*trace(L*J));

% compute m20
L34 = reshape(L,[1,1,n,n]);
m20 = sum(L.*G.*L34,'all');

% compute m12
M = zeros(n,n,n,n);
T = getSymm4Mask_subtypes(n);
w = getSymm4Weights_subtypes(n);
for ii=1:15
    M(T(:,:,:,:,ii)) = sum(G(T(:,:,:,:,ii)))*w(ii);
end

m12 = sum(L.*M.*L34,'all') ;
end