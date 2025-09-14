function ptr = pagetrace(A)
%PAGETRACE Summary of this function goes here
%   Detailed explanation goes here
sz  = size(A);
if numel(sz)<3
    ptr = trace(A);
else
    n   = size(A,1);
    A   = reshape(A,n^2,[]);
    idx = 1:(n+1):n^2;
    ptr = sum(A(idx,:));
    ptr = reshape(ptr,[1,1,sz(3:end)]);
end

end

