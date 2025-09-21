function ws = weinSumSlow(Q,x,Tq)
%SLOWWEINSUM Summary of this function goes here
%   Detailed explanation goes here

n    = length(x);
X    = x.*reshape(x,[1,n,1,1]).*reshape(x,[1,1,n,1]).*reshape(x,[1,1,1,n]);

w     = getSymm4Weights_subtypes(n);
Qbig  = Q.*reshape(Q,[1,1,n,n]);

X2 = reshape(X,[n^4,1]);
ws = 0;
for ii=1:15
    ss=sum(X2(Tq(:,ii),:)*w(ii),1);
    ws = ws + sum(Qbig(Tq(:,ii))).*ss;
end

end

