% compare wcp objective to the free period power
clear;
tic;
addpath('../utils')
addpath('../../preprint/utils/')

%rng('default')
cf    = 1;
Nperm = 1e3;
Nsamp = 5e2;

Nms   = [16,24,32,40,48];
nrep  = 1e2;

timestamp = string(datetime('now','Format','yyyyMMdd_HHmmss'));
out_dir = sprintf('prS1data_Nsamp%d_Nperm%d_cf%g_%s', ...
                  Nsamp, Nperm, cf, timestamp);
if ~exist(out_dir,'dir')
    mkdir(out_dir);
end

for Nmeas=Nms
    fprintf('Running Nmeas = %d\n', Nmeas);
    count = 0;
    fmin  = 1;
    fmax  = Nmeas/2;
    p1vec = [];p2vec = [];Ampvec=[];
    while count < nrep
        Amp = 1 + rand;
        tt  = rand(Nmeas,1);
        [p1,p2,incl] = getPowers(tt,Nsamp,fmin,fmax,Nperm,cf,Amp);
        if incl
            count  = count+1;
            p1vec  = [p1vec;p1];
            p2vec  = [p2vec;p2];
            Ampvec = [Ampvec;Amp];
        end
    end
    mm = [Ampvec p1vec p2vec];
    out_file = fullfile(out_dir, sprintf('mm_Nmeas%d.csv', Nmeas));
    writematrix(mm, out_file);
    fprintf('Saved results to %s\n', out_file);

end
toc

function [pwr_fixed,pwr_free,incl] = getPowers(tt,Nsamp,fmin,fmax,Nperm,cf,Amp)
alpha     = 0.05;
Nmeas     = length(tt); 
f0        = finv(1-alpha,2,Nmeas-3);
freqs     = linspace(fmin,fmax,1e2);
pwrs      = arrayfun(@(freq) ...
                ncfcdf(f0,2,Nmeas-3,Amp^2*getMinEig(tt,freq),'upper'), ...
                freqs);
pwr_fixed = min(pwrs);
if  (pwr_fixed < .98) | (pwr_fixed <.1)
    pwrs_free = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,cf,Amp);
    pwr_free  = min(pwrs_free);
    incl =true;
else
    pwr_free =NaN;
    incl = false;
end
end
