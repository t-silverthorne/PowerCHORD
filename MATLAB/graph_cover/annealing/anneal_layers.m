clear;
addpath('../')
nLayer = 3;

nvec = [4 4 48];
mvec = [3 3 1];
Tvec = [4 4 24];
nLayer = length(Tvec);
x = struct();

% construct permutations
for ii=1:(nLayer-1)
    x.Pcell{ii} = randsample(1:nvec(ii+1)*mvec(ii+1), ...
                          nvec(ii+1)*mvec(ii+1));
end

% construct shifts
for ii=1:nLayer
    x.alpha{ii} = zeros(mvec(ii),1);
end

% construct distance matrices
for ii=1:nLayer
    x.Dmats{ii} = get_chain_dist(nvec(ii),Tvec(ii),mvec(ii), ...
        x.alpha{ii},false);
end
x.nvec=nvec;x.mvec=mvec;x.Tvec=Tvec;

cFun_wrap = @(x) cFun_layer(x.Pcell,x.Dmats);

x=annealFun_layer(x,.1);

maxiter=1e6;
tic
Tnow = 20; % intial temperature
beta = .99999;
fX   = cFun_wrap(x);
t    = 1;
continue_bin = true;
while t<maxiter && continue_bin
    y = annealFun_layer(x,.01);
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
    if mod(t,1e5)==0
        Tnow=Tnow*9.9;
    end
    fprintf('%f \n',fX)
    t=t+1;
end
toc


%%
runTest=false;
if runTest
    cFun_layer(x.Pcell,x.Dmats)
    cFun_single(x.Pcell{1},x.Dmats{1},x.Dmats{2}) + ...
        cFun_single(x.Pcell{2},x.Dmats{2},x.Dmats{3}) 
end

