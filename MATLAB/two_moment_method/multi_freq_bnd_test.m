clear;clf;
rng('default')
n     = 32;
tt    = linspace(0,1,n+1);
tt    = tt(1:end-1)';
T     = getSymm4Mask_subtypes(n);
alpha = .05;
fmaxs = [1 1.25 1.5 1.75 2];
for fmax=fmaxs
    
    fmin  = 1;
    Nfreq = 1000;
    freqs = linspace(fmin,fmax,Nfreq);
    H     = [0 1 0; 0 0 1];
    Ltot = 0;
    for freq=freqs
        X     = [ones(n,1) cos(2*pi*freq*tt) sin(2*pi*freq*tt)];
        L     = H*((X'*X)\(X'));
        L     = L'*L;
        Ltot  = Ltot + L/Nfreq;
    end
    L=Ltot;
    
    Sigma = eye(n);
    
    Amp   = 10;
    thvals = linspace(0,2*pi,2^7+1);
    thvals = thvals(1:end-1);
    bvals = arrayfun(@(th) get2mBound(L,Sigma,...
        X*[0 Amp*cos(freq*th) Amp*sin(freq*th)]',alpha,T),thvals);
    
    plot(thvals,bvals,'-k')
    hold on
    drawnow
end