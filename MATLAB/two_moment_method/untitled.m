% check if desgin converges to equispaced for 1 freq
clear; clf;
% setup
n     = 24;
H     = [0 1 0; 0 0 1];
alpha = .05;
Amp   = 100;
Sigma = eye(n);
[T,Tlin] = getSymm4Mask_subtypes(n);
thvals = linspace(0,1,2^6+1);
thvals = thvals(1:end-1);

plot_init =true;
if plot_init
    %eval for equispaced
    tt    = linspace(0,1,n+1);
    tt    = tt(1:end-1)';
    X     = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
    L     = H*((X'*X)\(X'));
    L     = L'*L;
    pwrs  = arrayfun(@(th) get2mBound(L,Sigma,X*[0 Amp*cos(th) Amp*sin(th)]',alpha,Tlin),thvals)
    % clf
    % plot(thvals,pwrs,'.k')
    % ylim([0,1])
    min(pwrs)
    % %eval for rand
    % tt    = rand(n,1);
    % X     = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
    % L     = H*((X'*X)\(X'));
    % L     = L'*L;
    % min(arrayfun(@(th) get2mBound(L,Sigma,X*[0 Amp*cos(th) Amp*sin(th)]',alpha,Tlin),thvals))
end
% optimise
rng default % For reproducibility
myJfun2 = @(tt) -1*myJfun(tt,Sigma,Tlin,Amp,thvals,alpha);
Acstr = orderConstraintMat(n);
ceps  = 1/n/3;
ttr = randInitDesign(n,ceps);
bb1 = min(ttr)>=0;
bb2 = max(ttr)<=1;
bb3 =all(Acstr*ttr < -ceps);
bb1&bb2&bb3
opts = optimoptions(@fmincon,'Algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    myJfun2,'x0',ttr,'Aineq',Acstr,'bineq',-ceps*ones(n-1,1),'lb',zeros(n,1),'ub',ones(n,1),'options',opts);
ms = MultiStart('UseParallel',false);

tic;[x,f] = run(ms,problem,1);toc
f=-f
%%
% gs = GlobalSearch;
% %%
% tic;[x,f] = run(gs,problem);toc


function J = myJfun(tt,Sigma,Tlin,Amp,thvals,alpha)
% objective function wrapper
n   = length(tt);
H   = [0 1 0; 0 0 1];
X   = [ones(n,1) cos(2*pi*tt) sin(2*pi*tt)];
L   = H*((X'*X)\(X'));
L   = L'*L;
J   =min(arrayfun(@(th) get2mBound(L,Sigma,X*[0 Amp*cos(th) Amp*sin(th)]',alpha,Tlin),thvals));
end