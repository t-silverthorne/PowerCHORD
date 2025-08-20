function [A1,A2,A3,B1,B2,B3] = getIsserlisTensor_Sigma_Vect(Sigma)
%GETISSERLISTENSORVECT_HELP1 Summary of this function goes here
%   Detailed explanation goes here

% mu should be of size nx1x1x1xn5xn6  and C should be of size  nxnx1x1xn5xn6
n  = size(Sigma,1);
n5 = size(Sigma,5);
n6 = size(Sigma,6);

A1  = repmat(Sigma, [1,1,n,n,1,1]); % first term
B1  = reshape(Sigma,[1,1,n,n,n5,n6]);
B1  = repmat(B1,[n,n,1,1,1,1]);

A2  = reshape(Sigma,[n,1,n,1,n5,n6]); % second term
A2  = repmat(A2,[1,n,1,n,1,1]); 
B2  = reshape(Sigma,[1,n,1,n,n5,n6]);
B2  = repmat(B2,[n,1,n,1,1,1]);

A3  = reshape(Sigma,[n,1,1,n,n5,n6]); % third term
A3  = repmat(A3,[1,n,n,1,1,1]);
B3  = reshape(Sigma,[1,n,n,1,n5,n6]);
B3  = repmat(B3,[n,1,1,n,1,1]);

end

