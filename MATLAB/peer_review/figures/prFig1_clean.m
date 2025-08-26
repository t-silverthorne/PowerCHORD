clear;clf;
addpath('../../preprint/utils/')
addpath('../utils')
addpath('../../other/perm_test_utils/')

% load designs
data = readtable('diffEvolveOutput.csv');

Nmvals = [16,24,32,40,48];
Nsamp  = 1e1;
Nperm  = 1e3;
cfact  = .95;

out_pwr  = struct(); 
out_pwru = struct();
out_PWR  = struct();
out_PWRU = struct();

for Nmeas=Nmvals
    fprintf('Running Nmeas = %d\n', Nmeas);

    fmin   = 1;
    fmax   = Nmeas/2;
    mt     = data(data.Nmeas==Nmeas & data.fmin==fmin & data.fmax == fmax,:);
    tt     = mt{:,9:(9+Nmeas-1)}';
    if length(tt)~=Nmeas
        error('check table')
    end    
    [pwr,PWR]   = estimateFreePeriodPower(tt,Nsamp,fmin,fmax,Nperm,1);
    
    tu = linspace(0,1,Nmeas+1);
    tu = tu(1:end-1)';
    [pwru,PWRU] = estimateFreePeriodPower(tu,Nsamp,fmin,fmax,Nperm,.95);

    ts = string(datetime('now','Format','yyyyMMdd_HHmmss'));
    
    param_str = sprintf('Nsamp%d_Nperm%d_c%.2f', Nsamp, Nperm, cfact);
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
    
    pwr_file  = fullfile(out_dir,  sprintf('pwr_%s.csv', ts));
    pwru_file = fullfile(out_dir,  sprintf('pwru_%s.csv', ts));
    PWR_file  = fullfile(out_dir,  sprintf('PWR_%s.csv', ts));
    PWRU_file = fullfile(out_dir,  sprintf('PWRU_%s.csv', ts));

    writetable(pwr_tbl,  pwr_file);
    writetable(pwru_tbl, pwru_file);
    writetable(PWR_tbl,  PWR_file);
    writetable(PWRU_tbl, PWRU_file);
end

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


% curve comparison