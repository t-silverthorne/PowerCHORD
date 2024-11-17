function D = get_chain_dist(n,T,m,alpha,use_yalmip)

% distance block
Db = get_cyclic_dist(n,T);

% shift matrix, writing explicitly for YALMIP compatibility
for ii=1:m
    for jj=1:m
        S(ii,jj)=alpha(ii)-alpha(jj);
    end
end

if use_yalmip
    D = blkvar;
    for ii=1:m
        for jj=1:m
            D(ii,jj) = Db + alpha(jj)-alpha(ii);
        end
    end
else
    D = zeros(n*m,n*m); 
    for ii=1:m
        for jj=1:m
            D((ii-1)*n + (1:n),(jj-1)*n + (1:n)) = Db + alpha(jj)-alpha(ii);
        end
    end


end
end

