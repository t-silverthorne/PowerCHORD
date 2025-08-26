% compare wcp optimal vs equispaced for freq window [1,N/2] for various
% values of N, use bandlimit for equispaced to avoid numerical instability

clear;clf;
addpath('../../preprint/utils/')
addpath('../utils')
addpath('../../other/perm_test_utils/')

% load designs
data = readtable('diffEvolveOutput.csv');

Nmvals = [16,24,32,40,48];
Nsamp  = 5e2;
Nperm  = 1e3;
cfact  = .95;
Amp    = 2;

out_pwr  = struct(); 
out_pwru = struct();
out_PWR  = struct();
out_PWRU = struct();
ts = string(datetime('now','Format','yyyyMMdd_HHmmss'));

for Nmeas=Nmvals
    fprintf('Running Nmeas = %d\n', Nmeas);

    fmin   = 1;
    fmax   = Nmeas/2;
    mt     = data(data.Nmeas==Nmeas & data.fmin==fmin & data.fmax == fmax,:);
    tt     = mt{:,9:(9+Nmeas-1)}';
    if length(tt)~=Nmeas
        error('check table')
    end    
    [pwr,PWR]   = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,1,Amp);
    
    tu = linspace(0,1,Nmeas+1);
    tu = tu(1:end-1)';
    [pwru,PWRU] = estimateFreePeriodPower(tu,Nsamp,fmin,fmax,Nperm,.95,Amp);

    
    param_str = sprintf('prFig1data_Nsamp%d_Nperm%d_c%d_Amp%d', Nsamp, Nperm, ...
                            round(cfact*100), Amp);
    out_dir   = fullfile(pwd, sprintf('results_%s_%s', param_str, ts));
    if ~exist(out_dir, 'dir')
        mkdir(out_dir);
    end

    out_pwr.(sprintf("N%d",Nmeas))  = pwr;
    out_pwru.(sprintf("N%d",Nmeas)) = pwru;
    out_PWR.(sprintf("N%d",Nmeas))  = PWR;
    out_PWRU.(sprintf("N%d",Nmeas)) = PWRU;

    pwr_tbl  = struct2table(out_pwr,  'AsArray', true);
    pwru_tbl = struct2table(out_pwru, 'AsArray', true);
    PWR_tbl  = struct2table(out_PWR,  'AsArray', true);
    PWRU_tbl = struct2table(out_PWRU, 'AsArray', true);
    
    pwr_file  = fullfile(out_dir,  'pwr.csv');
    pwru_file = fullfile(out_dir,  'pwru.csv');
    PWR_file  = fullfile(out_dir,  'PWR.csv');
    PWRU_file = fullfile(out_dir,  'PWRU.csv');
    
    writetable(pwr_tbl,  pwr_file);
    writetable(pwru_tbl, pwru_file);
    writetable(PWR_tbl,  PWR_file);
    writetable(PWRU_tbl, PWRU_file);
end

% curve comparison