function [pwrbnd,sgn] = evalChebPowerbnd(Q,x,Tq,alpha,sliceSize)
%EVALCHEBPOWERBND Summary of this function goes here
%   Detailed explanation goes here
arguments
    Q (:,:) double;
    x double;
    Tq  (:,:) logical;
    alpha double;
    sliceSize=Inf;
end
if sliceSize==Inf % no slicing
    pbnd = evalChebPbnd(Q,x,Tq);
else
    sz = size(x); % with slicing
    assert(mod(sz(5),sliceSize)==0,'dim 5 must be divisible by sliceSize');
    nSlices = floor(sz(5)/sliceSize);
    xrs = reshape(x,[sz(1:4),sliceSize,nSlices,sz(6:end)]);
    
    szrs = size(xrs);
    pbnd = NaN([1,szrs(2:end)]); 
    for kk=1:nSlices
        pbnd(:,:,:,:,:,kk,:) = evalChebPbnd(Q,xrs(:,:,:,:,:,kk,:),Tq);
    end
    pbnd   = reshape(pbnd,[1,sz(2:end)]);

end
mp     = mean(pbnd,5);
vp     = mean(pbnd.^2,5)-mp.^2;
sgn    = mp<alpha;
pwrbnd = vp./(vp+(alpha-mp).^2);
end

