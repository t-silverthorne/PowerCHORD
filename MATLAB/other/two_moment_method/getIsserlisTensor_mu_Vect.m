function Mvect = getIsserlisTensor_mu_Vect(mu,A1,A2,A3,B1,B2,B3)
%GETISSERLISTENSOR vectorised version of getIsserlisTensor 

% mu should be of size nx1x1x1xn5xn6  and C should be of size  nxnx1x1xn5xn6
n  = size(mu,1);
n5 = size(mu,5);
n6 = size(mu,6);

mu1 = reshape(mu,[n,1,1,1,n5,n6]);
mu2 = reshape(mu,[1,n,1,1,n5,n6]);
mu3 = reshape(mu,[1,1,n,1,n5,n6]);
mu4 = reshape(mu,[1,1,1,n,n5,n6]);

Mvect = A1.*B1 + A2.*B2 + A3.*B3 + ...
		mu1.*mu2.*B1 + mu1.*mu3.*B2 + mu1.*mu4.*B3+ ...
		A1.*mu3.*mu4 + A2.*mu2.*mu4 + A3.*mu2.*mu3+ ...
		   mu1.*mu2.*mu3.*mu4;
end
