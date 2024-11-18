function Pnew = tFun_single(Pvec)
% permute two indices
Pnew = Pvec;
swap = randsample(1:length(Pvec),2);
Pnew(flip(swap)) = Pvec(swap);
end