function p_est = fastMCTinfpower(Qf,x,Nperm,alpha)
%FASTMCT2PVAL fast Monte Carlo estimate of the 
% T2 test statistic permutation p-value
Tobs = max(pagemtimes(pagetranspose(x),pagemtimes(Qf,x)),[],3);
sz   = size(x);
n    = sz(1);

nTrailing = prod(sz(2:end));
x_flat    = reshape(x, n, nTrailing);
xfp       = zeros(size(x_flat));

count = 0;
for pp=1:Nperm
    [~,perms] = sort(rand(n,nTrailing),1);
    for jj = 1:nTrailing
        idx = perms(:,jj);
        xfp(:,jj) = x_flat(idx,jj);
    end
    xp    = reshape(xfp, sz);
    Tperm = max(pagemtimes(pagetranspose(xp),pagemtimes(Qf,xp)),[],3);
    count   = count + (Tperm>Tobs);
end
p_est = mean(count<alpha,5); % only average over sample dim
end

