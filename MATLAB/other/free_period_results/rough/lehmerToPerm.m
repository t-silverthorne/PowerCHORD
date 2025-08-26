function Lmat = lehmerToPerm(Lmat,shift_zero)
%LEHMERTOPERM convert matrix of Lehmer codes to permutations on 0:(n-1)
arguments
    Lmat ;
    shift_zero =true;
end
n = size(Lmat,2);
for ii=(n-1):-1:1
    mask       = (Lmat>=Lmat(:,ii));
    mask       = mask&[false(1,ii) true(1,n-ii)];
    Lmat(mask) = Lmat(mask)+1;
end
if shift_zero % MATLAB uses 1 based indexing
    Lmat = Lmat+1;
end
end

