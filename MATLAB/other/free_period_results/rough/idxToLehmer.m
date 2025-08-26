function Lmat = idxToLehmer(kvec,n)
%IDXTOLEHMER convert k between 0 : n-1 to Lehmer code

Lmat = NaN(length(kvec),n);

qq = kvec;
for dd=1:n
    rr = rem(qq,dd);
    qq = floor(qq/dd);
    Lmat(:,n+1-dd) = rr;
end
end

