function [pwrbnd,sgn] = evalChebPowerbnd(Q,x,Tq,alpha)
%EVALCHEBPOWERBND Summary of this function goes here
%   Detailed explanation goes here
pbnd   = evalChebPbnd(Q,x,Tq);
mp     = mean(pbnd,5);
vp     = mean(pbnd.^2,5)-mp.^2;
sgn    = mp<alpha;
pwrbnd = vp./(vp+(alpha-mp).^2);
end

