function [power_est,perm_pvals] = fastMCTinfpower(Qf,x,Nperm,alpha,compute_power)
%FASTMCTINFPVAL fast Monte Carlo estimate of the Tinf test statistic permutation p-value
if nargin<5
    compute_power=true;
end
Tobs = max(pagemtimes(pagetranspose(x),pagemtimes(Qf,x)),[],3);
sz   = size(x);
n    = sz(1);

nTrailing = prod(sz(2:end));
x_flat    = reshape(x, n, nTrailing);

count = 0;
for pp=1:Nperm
    xfp       = zeros(size(x_flat));
    [~,perms] = sort(rand(n,nTrailing),1);
    for jj = 1:nTrailing
        idx = perms(:,jj);
        xfp(:,jj) = x_flat(idx,jj);
    end
    xp    = reshape(xfp, sz);
    Tperm = max(pagemtimes(pagetranspose(xp),pagemtimes(Qf,xp)),[],3);
    count = count + (Tperm>Tobs);
end
perm_pvals = count/Nperm;
if compute_power
    power_est = mean(perm_pvals<alpha,5); % average over sample dim
else
    power_est = NaN;
end

