% trying perm test for single frequency and data from wrong model
clear
addpath('peer_review/utils/')
n  = 48;
Amp = 4; 
nrep = 1e4
fprintf('-------\n')
tt = rand(n,1);
Q  = getQuadForm(tt,1);
for ii=1:nrep
    acro = 2*pi*rand;
    x  = Amp*cos(2*pi*tt-acro) + randn(size(tt));
    pbnd(ii) = getExactPermMoment1(Q,x)/(x'*Q*x);
end
fprintf('Power rand %f\n',mean(pbnd<.05))

tt = (0:n-1)'/n;
Q  = getQuadForm(tt,1);
for ii=1:nrep
    acro = 2*pi*rand;
    x  = Amp*cos(2*pi*tt-acro) + randn(size(tt));
    pbnd(ii) = getExactPermMoment1(Q,x)/(x'*Q*x);
end
fprintf('Power unif %f\n',mean(pbnd<.05))
