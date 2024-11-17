function A = get_cyclic_dist(n,T)
% distance matrix of cyclic graph mod T

A = zeros(n,n);
for ii=1:n
    for jj=(ii+1):n
        A(ii,jj) = (jj-ii)*T/n;
    end
end
A=A-A';
end