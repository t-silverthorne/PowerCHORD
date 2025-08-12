%rng('default')
%% Simple example
n   = 7;
A   = eye(n);
A34 = reshape(A,[1,1,n,n]);

mu  = zeros(n,1);
C   = eye(n);
G   = getIsserlisTensor(C,mu); % matrix of 4th moments

M = zeros(n,n,n,n);
T = getSymm4Mask_subtypes(n);
w = getSymm4Weights_subtypes(n);

for ii=1:15
    M(T(:,:,:,:,ii)) = sum(G(T(:,:,:,:,ii)))*w(ii);
end

sum(A.*M.*A34,'all') == n^2+2*n;