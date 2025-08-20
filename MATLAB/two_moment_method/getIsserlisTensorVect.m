function Mvect = getIsserlisTensorVect(C,mu)
%GETISSERLISTENSOR vectorised version of getIsserlisTensor 

% mu should be of size nx1x1x1xn5xn6  and C should be of size  nxnx1x1xn5xn6
n  = size(mu,1);
n5 = size(mu,5);
n6 = size(mu,6);
if size(mu) != [n,1,1,1,n5,n6]
	error('Incorrect mean size');
end
if size(C)  != [n,n,1,1,n5,n6]
	error('Incorrect cov mat size');
end

A1  = repmat(C, [1,1,n,n,1,1]); % first term
B1  = reshape(C,[1,1,n,n,n5,n6]);
B1  = repmat(B1,[n,n,1,1,1,1]);

A2  = reshape(C,[n,1,n,1,n5,n6]); % second term
A2  = repmat(A2,[1,n,1,n,1,1]); 
B2  = reshape(C,[1,n,1,n,n5,n6]);
B2  = repmat(B2,[n,1,n,1,1,1]);

A3  = reshape(C,[n,1,1,n,n5,n6]); % third term
A3  = repmat(A3,[1,n,n,1,1,1]);
B3  = reshape(C,[1,n,n,1,n5,n6]);
B3  = repmat(B3,[n,1,1,n,1,1]);

mu1 = reshape(mu,[n,1,1,1,n5,n6]);
mu2 = reshape(mu,[1,n,1,1,n5,n6]);
mu3 = reshape(mu,[1,1,n,1,n5,n6]);
mu4 = reshape(mu,[1,1,1,n,n5,n6]);

Mvect = A1.*B1 + A2.*B2 + A3.*B3 + ...
		mu1.*mu2.*B1 + mu1.*mu3.*B2 + mu1.*mu4.*B3+ ...
		A1.*mu3.*mu4 + A2.*mu2.*mu4 + A3.*mu2.*mu3+ ...
		   mu1.*mu2.*mu3.*mu4;
end
