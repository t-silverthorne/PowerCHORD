addpath('../')
% params
n1   = 6;
m1   = 2;
T1   = 6;
n2   = 12;
m2   = 1;
T2   = 12;
N    = n1*m1;

% optim variable
x        = struct();
x.Pvec   = randsample(1:n2*m2,n2*m2);
x.alpha1 = zeros(m1,1);
x.alpha2 = zeros(m2,1);
x.D1     = get_chain_dist(n1,T1,m1,x.alpha1,false);
x.D2     = get_chain_dist(n2,T2,m2,x.alpha2,false);
x.n1=n1;x.n2=n2;x.m1=m1;x.m2=m2;x.T1=T1;x.T2=T2;

cFun_wrap = @(x) cFun_single(x.Pvec,x.D1,x.D2);
cFun_wrap(x)


maxiter=1e5;
tic
Tnow = 20; % intial temperature
beta = .9999;
fX   = cFun_wrap(x);
t    = 1;
continue_bin = true;
while t<maxiter && continue_bin
    y = annealFun_single(x,.1);
    fY = cFun_wrap(y);
    alpha=min( exp( - (fY - fX )/Tnow) , 1);
    if rand<=alpha
        x=y;
        fX=fY;
        if fX==0
            continue_bin=false;
        end
    end
    Tnow=beta*Tnow;
    fprintf('%f \n',fX)
    t=t+1;
end
toc
