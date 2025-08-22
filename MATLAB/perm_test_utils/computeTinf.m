function Tinf=computeTinf(tt,y,freqs)
Nf    = length(freqs);
freqs = reshape(freqs,[1,1,Nf]);
X     = [ones(length(tt),1,Nf) cos(2*pi*freqs.*tt) sin(2*pi*freqs.*tt)];
bhat  = pagemldivide(X,y);
Tinf  = max(bhat(2,:,:,:,:).^2+bhat(3,:,:,:,:).^2,[],3); % take mean over freq dim
end