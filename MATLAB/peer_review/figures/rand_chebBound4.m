% Setup simulated annealing
clear;clf;
'a'
runSA(4,1,100) % N/4 harmonic
'b'
runSA(4,2,100)
'c'
runSA(4,5,100)
'd'

runSA(3,1,100) % N/3 harmonic
'e'
runSA(3,2,100)
'f'
runSA(3,5,100)
'g'

runSA(2,1,100) % N/2 harmonic
'h'
runSA(2,2,100)
'i'
runSA(2,5,100)


'a'
runSA(4,1,1000) % N/4 harmonic
'b'
runSA(4,2,1000)
'c'
runSA(4,5,1000)
'd'

runSA(3,1,1000) % N/3 harmonic
'e'
runSA(3,2,1000)
'f'
runSA(3,5,1000)
'g'

runSA(2,1,1000) % N/2 harmonic
'h'
runSA(2,2,1000)
'i'
runSA(2,5,1000)


function [fval,fbench]=runSA(harm,Amp,MaxIter)
	rng('default');
	addpath('../utils')
	Nmeas = 48;
	Nfreq = 64;
	Nacro = 64;
	Nsamp = 1e2;
	fmin  = 1;
	fmax  = Nmeas/harm;

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
	    'MaxIterations',MaxIter, ...
	    'MaxFunctionEvaluations',1e4);

	% Run simulated annealing
	[tt_opt,fval,exitflag,output] = simulannealbnd(Jwrap,tt0,lb,ub,options);
	save(sprintf('tt_opt_%d_%d_%d_N%d_%d_%d.mat',Nmeas,Nfreq,Nacro,harm,Amp,MaxIter),'tt_opt')

	% Benchmark result on higher resolution grid
	tt    = tt_opt;
	Nfreq = 64;
	Nacro = 64;
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
	%plot(squeeze(freqs),squeeze(min(pwr2,[],2)),'--k','LineWidth',1)
	fbench = min(pwr2,[],'all');
	
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
end
