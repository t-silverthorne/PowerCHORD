function [bhat,rss] = fitCosinorSingleFreq(tt,yobs,freq)
%FITCOSINORSINGLEFREQ Summary of this function goes here
%   Detailed explanation goes here
arguments
    tt (:,1) double;
    yobs;
    freq double;
end
X    = [ones(length(tt),1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
bhat = X\yobs;
rss  = sum((yobs-X*bhat).^2);
end

