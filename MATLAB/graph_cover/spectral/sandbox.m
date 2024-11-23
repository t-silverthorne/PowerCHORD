addpath('../')

n=5;
A=randn(n,n,2);
P=randperm(n);
I=eye(n);
Pmat=I(1:n,P);
max(max(abs(sort(pageeig(A))-sort(pageeig(pagemtimes(Pmat',pagemtimes(A,Pmat)))))))

ndgrid(1:10,)
%%
Smat = 
avec = ;
D1   = get_chain_dist()