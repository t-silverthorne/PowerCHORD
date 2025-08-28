% check how Tinf statistic behaves on randomly generated design
clear;clf;
tic;
rng(1)
Nmeas = 32;
Nfreq = 16;
Nacro = 128;
Nsamp = 1e2;
addpath('../utils')

fmin = 1;
fmax = Nmeas/3;
Amp  = 10;

for ii=1:10
    if ii==1
        tt   = linspace(0,1,Nmeas+1);
        tt   = tt(1:end-1)';
    else
        tt   = rand(Nmeas,1);
    end
    
    % construct test statistic
    if ii==1
        fqf_2    = reshape(linspace(fmin,0.95*fmax,1e3),1,1,[]);
    else
        fqf_2    = reshape(linspace(fmin,fmax,1e3),1,1,[]);
    end
    
    Q2       = getQuadForm(tt,fqf_2);
    
    % simulate signal
    freqs = linspace(fmin,fmax,Nfreq);
    acros = linspace(0,2*pi,Nacro+1);
    acros = acros(1:end-1);
    freqs = reshape(freqs,1,1,1,1,1,[]);
    acros = reshape(acros,1,1,1,1,1,1,[]);
    
    mu    = Amp*cos(2*pi*freqs.*tt -acros);
    sz    = size(mu);
    x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);
   
    % estimate power
    [pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05);
    pwr2 = pwr2.*((-1).^(~sgn));
    pwr2 = squeeze(pwr2);
   
    if ii==1
        plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--k')
        hold on
        drawnow
        ylim([0,1])
    else
        plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--b')
        hold on
    end
    ylim([0,1])
end
toc