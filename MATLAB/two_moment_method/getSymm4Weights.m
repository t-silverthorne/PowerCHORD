function [wa,wb,wc,wd,we] = getSymm4Weights(n)
%GETSYMM4WEIGHTS weights for computing 4th moment on symm group
bvec = [4,3,2,2,1];
wvec = factorial(n-bvec)./factorial(n);
wa=wvec(1);wb=wvec(2);wc=wvec(3);wd=wvec(4);we=wvec(5);
end

