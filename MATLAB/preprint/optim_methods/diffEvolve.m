function [Tmat,eigfinal,scores] = diffEvolve(Nm,fmin,fmax,Nfreq,settings)
% OUTPUT:
%   Tmat      final population matrix
%   eigfinal  noncentrality parameters of final population
%   scores    shows best score at each generation


% unpack inputs
Npop       = settings.Npop;
Niter      = settings.Niter;
time_max   = settings.time_max;
eps        = settings.eps;
CR         = settings.CR;
useGPUglob = settings.useGPUglob;

Tmat       = rand(Nm,Npop);
scores     = [];
tic
ii=1;
while (ii <=Niter) && (toc<time_max)
    % score population
    [~,Jnow]         = getMinEigMulti(Tmat,fmin,fmax,Nfreq,useGPUglob);
    scores(ii)       = max(Jnow);
    
    % evolution
    cind             = cell2mat(arrayfun(@(ii) randsample(1:Npop,3,false)',1:Npop,'UniformOutput',false));
    Tcand            = Tmat(:,cind(1,:)) + eps*(Tmat(:,cind(2,:)) - Tmat(:,cind(3,:)));
    Tcand            = mod(Tcand,1);

    % crossover
    Tcr              = Tmat;
    ind_cross        = rand(Nm,Npop)<CR;
    Tcr(ind_cross)   = Tcand(ind_cross);
    
    
    % evolve population
    [~,Jcr]          = getMinEigMulti(Tcr,fmin,fmax,Nfreq,useGPUglob);
    Tmat(:,Jcr>Jnow) = Tcr(:,Jcr>Jnow);

    ii=ii+1;
end
[~,eigfinal] = getMinEigMulti(Tmat,fmin,fmax,Nfreq,useGPUglob);
end


