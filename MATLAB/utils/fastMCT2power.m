function pwr_est = fastMCT2power(Q,x,Nperm,alpha)
%FASTMCT2PVAL fast Monte Carlo estimate of the 
% T2 test statistic permutation p-value
Tobs = pagemtimes(pagetranspose(x),pagemtimes(Q,x));
sz   = size(x);
n    = sz(1);

if ~ismatrix(Q)
    error('Q must be a matrix.');
end

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
    Tperm = pagemtimes(pagetranspose(xp),pagemtimes(Q,xp));
    count = count + (Tperm>Tobs);
end
count   = count/Nperm;
pwr_est = mean(count<alpha,5); % only average over sample dim
end

