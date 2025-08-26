function [pwr,pwrGrid] = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,censor_factor, ...
                                                 Amp,Nfreq,Nacro,Nfq)
arguments
    tt    (:,1) double;
    Nsamp       double
    fmin        double;
    fmax        double;
    Nperm = 1e3;
    censor_factor = 1;
    Amp   = 2;
    Nfreq = 16;
    Nacro = 16;
    Nfq   = 100;

end
freqs = linspace(fmin,fmax,Nfreq); % freq and acro grids
acros = linspace(0,2*pi,Nacro+1);
acros = acros(1:end-1);
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);
mu    = Amp*cos(2*pi*freqs.*tt -acros); % simulated signal
sz    = size(mu);
x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);

fqf     = linspace(fmin,fmax*censor_factor,Nfq);
fqf     = reshape(fqf,1,1,[]);
[~,Q]   = getQuadForm(tt,fqf);
alpha   = .05;
pwrGrid = squeeze(fastMCTinfpower(Q,x,Nperm,alpha));
pwr     = min(pwrGrid,[],2);
end

