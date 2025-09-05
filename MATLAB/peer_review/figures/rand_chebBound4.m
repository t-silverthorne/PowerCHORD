Nmeas = 48;
Nfreq = 16;
Nacro = 16;
Nsamp = 1e1;
fmin  = 1;
fmax  = Nmeas/4;
Amp   = 5;

freqs = linspace(fmin,fmax,Nfreq);
acros = rand(Nacro,1)*2*pi;
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);
fqf_2 = reshape(linspace(fmin,fmax,1e3),1,1,[]);


tt    = linspace(0,1,Nmeas+1);
Jwrap = @(tt) - Jfun(tt,freqs,acros,fqf_2,Amp,Nsamp);

tt0 = linspace(0,1,Nmeas+1);
tt0 = tt0(1:Nmeas)';
lb = zeros(size(tt0));
ub = ones(size(tt0));
options = optimoptions('simulannealbnd', ...
    'Display','iter', ...
    'MaxIterations',1e2, ...
    'MaxFunctionEvaluations',1e4);

[tt_opt,fval,exitflag,output] = simulannealbnd(Jwrap,tt0,lb,ub,options);

tt    = tt_opt
Nfreq = 64;
Nacro = 32;
Nsamp = 1e2;
Q2    = getQuadForm(tt,fqf_2);

freqs = linspace(fmin,fmax,Nfreq);
acros = rand(Nacro,1)*2*pi;
freqs = reshape(freqs,1,1,1,1,1,[]);
acros = reshape(acros,1,1,1,1,1,1,[]);

mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);

x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);
[pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05);
pwr2 = pwr2.*((-1).^(~sgn));
pwr2 = squeeze(pwr2);
plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--k','LineWidth',1)
min(pwr2,'all')
function Jval = Jfun(tt,freqs,acros,fqf_2,Amp,Nsamp)
tt    = reshape(tt,[],1);
Q2    = getQuadForm(tt,fqf_2);

mu    = Amp*cos(2*pi*freqs.*tt -acros);
sz    = size(mu);
x     = mu + randn([sz(1:4),Nsamp,sz(6:end)]);
[pwr2,sgn] = evalChebPowerbnd(Q2,x,0.05);
pwr2 = pwr2.*((-1).^(~sgn));
Jval   =min(pwr2,[],'all');
end