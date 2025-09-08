function [pwr2_mc,pwrinf_mc,pwr2_ch,freqs_mc,freqs_ch]=benchmarkDesign(...
                         tt,fmin,fmax,Amp,...
                         Nfreq_ch,Nacro_ch,Nsamp_ch,Nfq_Tinf,Nfq_T2, ...
                         Nfreq_mc,Nacro_mc,Nsamp_mc,Nperm_mc,
						fmin_Q,fmax_Q)
fqf_inf   = reshape(linspace(fmin_Q,fmax_Q,Nfq_Tinf),1,1,[]);
fqf_2     = reshape(linspace(fmin_Q,fmax_Q,Nfq_T2),1,1,[]);
[~,Qinf] = getQuadForm(tt,fqf_inf);
[Q2,~] = getQuadForm(tt,fqf_2);

% get MC estimates of T2 and Tinf power
freqs_mc  = linspace(fmin,fmax,Nfreq_mc);
acros_mc  = linspace(0,2*pi,Nacro_mc+1);
acros_mc  = acros_mc(1:end-1);
freqs_mc  = reshape(freqs_mc,1,1,1,1,1,[]);
acros_mc  = reshape(acros_mc,1,1,1,1,1,1,[]);
mu        = Amp*cos(2*pi*freqs_mc.*tt -acros_mc);
sz        = size(mu);
x         = mu + randn([sz(1:4),Nsamp_mc,sz(6:end)]);
pwr2_mc   = min(squeeze(fastMCT2power(Q2,x,Nperm_mc,0.05)),[],2);
pwrinf_mc = min(squeeze(fastMCTinfpower(Qinf,x,Nperm_mc,0.05)),[],2);

% get Chebyshev bound on T2 power
freqs_ch      = linspace(fmin,fmax,Nfreq_ch);
acros_ch      = rand(Nacro_ch,1)*2*pi;
freqs_ch      = reshape(freqs_ch,1,1,1,1,1,[]);
acros_ch      = reshape(acros_ch,1,1,1,1,1,1,[]);
mu            = Amp*cos(2*pi*freqs_ch.*tt -acros_ch);
sz            = size(mu);
x             = mu + randn([sz(1:4),Nsamp_ch,sz(6:end)]);
[pwr2_ch,sgn] = evalChebPowerbnd(Q2,x,0.05,'rig');
pwr2_ch       = min(squeeze(pwr2_ch.*((-1).^(~sgn))),[],2);
freqs_mc = squeeze(freqs_mc);
freqs_ch = squeeze(freqs_ch);
end
