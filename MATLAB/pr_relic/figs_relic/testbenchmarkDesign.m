% wrapper for benchmarking design
clear;rng('default');
clf;
addpath('../utils')
Nmeas = 48; % number of measurements
fmin  = 1;         % min freq in window
fmax  = Nmeas/4;   % max freq in window
tt    = linspace(0,1,Nmeas+1);
tt    = tt(1:end-1)';

% cheb params
Nfreq_ch = 32; % num freqs for Cheb bound
Nacro_ch = 32; % num acros for Cheb bound
Nsamp_ch = 1e1; % for Cheb bound
Nfq_Tinf = 16; % num freqs for constructing test statistic
Nfq_T2   = 1e3; % num freqs for constructing test statistic

% Monte Carlo params
Nsamp_mc = 1e2; 
Nfreq_mc = 32;
Nacro_mc = 32;
Nperm_mc = 1e3; % Nperm for Monte Carlo

Amp=5;
tic;
[pwr2_mc,pwrinf_mc,pwr2_ch,fmc,fch]=benchmarkDesign(tt,fmin,fmax,Amp,...
                Nfreq_ch,Nacro_ch,Nsamp_ch,Nfq_Tinf,Nfq_T2, ...
                Nfreq_mc,Nacro_mc,Nsamp_mc,Nperm_mc)

toc
plot(fmc,pwrinf_mc,'-k')
hold on
plot(fmc,pwr2_mc,'-b')
hold on
plot(fch,pwr2_ch,'--b')