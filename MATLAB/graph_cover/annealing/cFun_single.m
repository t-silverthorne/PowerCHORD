function J = cFun_single(Pvec,D1,D2)
N = size(D2,1);
if size(D1,1) == size(D2,1)
    I    = eye(N);
    Pmat = I(1:N,Pvec);
else
    Pmat           = zeros(size(D2,1),size(D1,1));
    for ii=1:size(D1,1)
        Pmat(Pvec(ii),ii) = 1;
    end
end
J              = norm(Pmat'*D2*Pmat-D1);
end