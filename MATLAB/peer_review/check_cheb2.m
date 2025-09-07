% check cheb p-value bound
addpath("utils/")
n     = 12;
Nf    = 100;
tt    = rand(n,1);
freqs = [1,1.5,2];
freqs = reshape(freqs,1,1,[]);
Q     = getQuadForm(tt,freqs);
Amp   = 2; phi =rand*2*pi;
x     = Amp*cos(2*pi*1*tt-phi)+randn(n,1,1,1,4)
[pbnd,~,~,ss]=evalChebPbnd(Q,x);
squeeze(ss)
