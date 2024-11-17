yalmip('clear')
n=6;
P=binvar(n,n);
K=intvar(n,n);
T1=12;
alpha = sdpvar(1);
Db=[0  2  4
   -2  0  2
   -4 -2  0];
D1=[Db Db+alpha
    -(Db+alpha) Db];

optimize([P*D1 - D1*P == K*T1,sum(P)==1,sum(P')==1,K'==-K],-sum(sum(P)))
