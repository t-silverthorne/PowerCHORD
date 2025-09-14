addpath("utils/")
n          = 12;
nsamp      = 8*8;
x          = randn(n,nsamp);
[T,Tlin]   = getSymm4Mask_subtypes(n);
mask_layer = 10;

tic;
for mm = 1:15
    [i,j,k,l] = ind2sub([n,n,n,n], find(Tlin(:,mm)));
    sum(x(i,:).*x(j,:).*x(k,:).*x(l,:));
end
toc
n5 = size(x,2);

tic;
for mm = 1:15
    X  = reshape(x,[n,1,1,1,n5]).*reshape(x,[1,n,1,1,n5]).*reshape(x,[1,1,n,1,n5]).*reshape(x,[1,1,1,n,n5]);
    X2 = reshape(X,[n^4,n5]);
    sum(X2(Tlin(:,mask_layer),:));
end
toc
