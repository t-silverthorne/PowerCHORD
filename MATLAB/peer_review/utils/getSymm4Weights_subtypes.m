function wvec = getSymm4Weights_subtypes(n)
%GETSYMM4WEIGHTS weights for computing 4th moment on symm group
arguments
    n double;
end
bvec = [4,...        % type A
    3,3,3,3,3,3,...  % type B
    2,2,2,...        % type C
    2,2,2,2,...      % type D
    1];              % type E
wvec = factorial(n-bvec)./factorial(n);
end

