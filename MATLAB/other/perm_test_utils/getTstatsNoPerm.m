function [E_P,Var_P] = getTstatsNoPerm(Tvec1,Tvec2)
%GETTSTATSNOPERM Summary of this function goes here
%   Detailed explanation goes here
E_P   = mean(Tvec1);
Var_P = mean(Tvec2.^2)-mean(Tvec2).^2;
end

