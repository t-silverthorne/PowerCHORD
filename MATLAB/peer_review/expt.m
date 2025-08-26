% experimenting with ways of evaluating the contraction
addpath('utils/')
n = 48;
[T,Tlin] = getSymm4Mask_subtypes(n);
x = rand(n,1);
X = x.*reshape(x,[1,n,1,1]).*reshape(x,[1,1,n,1]).*reshape(x,[1,1,1,n]);
ss=0;
mask_layer = 13;
tic;
for ii=1:n
    for jj=1:n
        for kk=1:n
            for ll=1:n
                ss = ss + T(ii,jj,kk,ll,mask_layer)*X(ii,jj,kk,ll);
            end
        end
    end
end
ss;
toc
tic;sum(Tlin(:,mask_layer).*X(:));toc
tic;[i,j,k,l] = ind2sub([n,n,n,n], find(Tlin(:,mask_layer)));
sum(x(i).*x(j).*x(k).*x(l));toc
%%
xx = kron(x,x);            
S  = xx.' * T * xx;  