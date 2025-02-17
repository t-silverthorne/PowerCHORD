function emax = getMinEig(t,freq,method)
% return min eigenvalue of B inverse
arguments
    t;
    freq;
    method='schur';
end
A    = [0 0;1 0;0 1];
X    = [ones(length(t),1) cos(2*pi*freq*t) sin(2*pi*freq*t)];
B    = A'*((X'*X)\A);
switch method
    case 'schur'
        bvec = [sum(cos(2*pi*freq*t)); sum(sin(2*pi*freq*t))];
        Xr = [cos(2*pi*freq*t) sin(2*pi*freq*t)];
        M    = Xr'*Xr;
        emax = min(eig(M(1:2,1:2) - bvec*bvec'/length(t)));
    case 'div'
        emax = 1/max(eig(B));
    case 'inv'
        emax = min(eig(inv(B)));
    otherwise
        error('unknown method');
end
end

