clear
addpath('../utils')
n  = 12;
tt = linspace(0,1,n+1);
tt = tt(1:end-1)';

Nsamp  = 1e2;
Nperm  = 1e2;
Nfreq  = 16;
Nacro  = 16;
Nfq    = 200;

fmin=1;

parset=2.5
switch parset
    case 1
        fmax = n/3;
        Amp  = 2;  % amp=1 too low, amp=2
        cf   = 1;
    case 1.5
        fmax = n/3;
        Amp  = 2;  % amp=1 too low, amp=2
        cf   = .95;        
    case 2
        fmax = n/2;
        Amp  = 2;  % amp=1 too low, amp=2        
        cf   = .95;
    case 2.5
        fmax  = n/4;
        Amp   = 2.5;  % amp=1 too low, amp=2        
        cf    = .95;
        Nfreq = 16;
        Nacro = 64;
        Nfq   = 400;
end

tic;
estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,cf, ...
                                                 Amp,Nfreq,Nacro,Nfq)
toc
