function [pwrbnd,sgn] = evalChebPowerbnd(Q,x,alpha,method)
%EVALCHEBPOWERBND Summary of this function goes here
%   Detailed explanation goes here
[pbnd,~,~,sgnp] = evalChebPbnd(Q,x);
switch method
	case 'rig'
		pbnd(~sgnp) = 1;
	case 'naive'
	otherwise
		error("unknown method");
end
mp              = mean(pbnd,5);
vp              = mean(pbnd.^2,5)-mp.^2;
sgn             = mp<alpha;
pwrbnd          = 1-vp./(vp+(alpha-mp).^2);
end