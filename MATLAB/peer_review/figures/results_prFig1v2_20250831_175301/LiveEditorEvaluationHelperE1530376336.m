clear;
addpath('../../preprint/utils/')
addpath('../utils')
addpath('../../other/perm_test_utils/')

% load designs
data = readtable('diffEvolveOutput.csv');

% want to loop over Amp, Nmeas, and fmax
Amps   = [1,2];
Nmvals = [24,48];
Nsamp  = 500;
Nperm  = 1000;
results = struct();
ts = string(datetime('now','Format','yyyyMMdd_HHmmss'));

out_dir   = fullfile(pwd,sprintf('results_prFig1v2_%s', ts));
if ~exist(out_dir, 'dir')
    mkdir(out_dir);
end
copyfile([mfilename('fullpath'), '.m'], out_dir);

cfact=.95;
for Nmeas=Nmvals
    fmaxs=[Nmeas/2,Nmeas/3,Nmeas/4];
    for Amp=Amps
        for fmax=fmaxs
            fprintf('Running Nmeas = %d Amp= %d fmax=%d \n ', Nmeas,Amp,fmax);
            fmin=1;
            mt = data(data.Nmeas==Nmeas & data.fmin==fmin & data.fmax == fmax,:);
            tt = mt{:,9:(9+Nmeas-1)}';
            if length(tt)~=Nmeas
                error('check table')
            end    
            pwr  = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,1,Amp,32,32,500);
            tu   = linspace(0,1,Nmeas+1);
            tu   = tu(1:end-1)';
            pwru = estimateFreePeriodPower(tu,Nsamp,fmin,fmax,Nperm,cfact,Amp,32,32,500);

            % Store in structs with a unique field for this combination
            idx = sprintf('N%d_Amp%d_fmax%d', Nmeas, Amp, round(fmax));
            out_pwr.(idx)  = pwr;
            out_pwru.(idx) = pwru;
            

            pwr_tbl   = struct2table(out_pwr,  'AsArray', true);
            pwru_tbl  = struct2table(out_pwru, 'AsArray', true);

            writetable(pwr_tbl,  fullfile(out_dir, 'pwr.csv'));
            writetable(pwru_tbl, fullfile(out_dir, 'pwru.csv'));
        end
    end
end
