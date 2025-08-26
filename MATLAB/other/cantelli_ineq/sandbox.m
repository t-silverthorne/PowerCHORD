n=30;
x=rand(n,1);
tic
[x1,x2,x3,x4]=ndgrid(x,x,x,x);
y1=x1.*x2.*x3.*x4;
toc
tic
y2=x.*reshape(x,[1,n,1,1]).*reshape(x,[1,1,n,1]).*reshape(x,[1,1,1,n]);
toc
%%
n=5
nsamp=2;
x=rand(n,nsamp)
x=reshape(x,[n,1,1,1,nsamp])
reshape(x,[1,n,1,1,nsamp])
% x(1)*x(3)*x(5)*x(2)
% y1(1,3,2,5)
% y2(1,3,2,5)