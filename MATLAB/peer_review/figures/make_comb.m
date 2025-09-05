function tt = make_comb(n,nc,scale)
%MAKE_COMB Summary of this function goes here
%   Detailed explanation goes here
if mod(n,nc)~=0
    error('nc must divide n')
end
if scale >= 1/nc
    error('scale must be < 1/nc')
end

tbase = (0:nc-1)/nc;
tbase = tbase';
m = n/nc;
tt =[];
for jj=0:m-1
    tt = [tt;tbase+jj*scale/m];
end
tt = sort(tt);
end

