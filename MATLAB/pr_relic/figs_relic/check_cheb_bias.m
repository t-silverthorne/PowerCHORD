n = 40;
freqs = reshape([1,2],1,1,[]);
tt = rand(n,1);
Q = getQuadForm(tt,freqs);
[~,Tq] = getSymm4Mask_subtypes(n);
alpha = .15;
[pwr,sgn]=evalChebPowerbnd(Q,10*cos(2*pi*tt)+randn(n,1,1,1,100),Tq,alpha)