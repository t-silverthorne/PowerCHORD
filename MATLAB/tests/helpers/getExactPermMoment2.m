function m2 = getExactPermMoment2(Q,x,Tq)
%GETPERMMOMENT2 depracated and replaced by weinSumFastVect 
    Q (:,:)       double;
    x  double;
    Tq (:,:)      logical;
end
sz    = size(x);
if prod(sz(2:4))>1
    error("Intermediate dims must be of length 1")
end
n     = sz(1);
nsamp = sz(5);
X     = x.*reshape(x,[1,n,1,1,sz(5:end)]).*reshape(x,[1,1,n,1,sz(5:end)]).*reshape(x,[1,1,1,n,sz(5:end)]);

w     = getSymm4Weights_subtypes(n);
Qbig  = Q.*reshape(Q,[1,1,n,n]);

X2 = reshape(X,[n^4,prod(sz(5:end))]);
m2 = zeros(1,prod(sz(5:end)));
for ii=1:15
    ss=sum(X2(Tq(:,ii),:)*w(ii),1);
    m2 = m2 + sum(Qbig(Tq(:,ii))).*ss;
end
m2 = reshape(m2,[1,sz(2:end)]);
end

