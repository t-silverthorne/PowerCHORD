Nf    = 100;
n     = 100;
freqs = rand(1,1,Nf)*10;
tt    = rand(n,1);
y     = randn(n,1000);

tt_g    = gpuArray(tt);
y_g     = gpuArray(y);
freqs_g = gpuArray(freqs);

tic
computeT2(tt,y,freqs);
toc

tic
computeT2(tt_g,y_g,freqs_g);
toc